module API
  class Updater < API::Communicator

    attr_accessor :organization_instance

    def update!
      request!
      update_organization!
      update_pipes
    end

    private

    def update_organization!
      self.organization_instance = Organization.find_by_external_id(self.organization['id']) || Organization.new
      self.organization_instance.assign_attributes(prepare_hash(self.organization, ['pipes']))
      self.organization_instance.save!
    end

    def update_pipes
      received_pipes = []
      self.pipes.each do |pipe|
        received_pipes << pipe['id']
        @new_pipe = self.organization_instance.pipes.find_by_external_id(pipe['id']) || self.organization_instance.pipes.new
        @new_pipe.assign_attributes(prepare_hash(pipe.dup, ['users', 'labels', 'phases']))
        update_relations(pipe) if @new_pipe.save
      end

      destroy_non_receiveds(self.organization_instance, 'pipes', received_pipes)
    end

    def update_relations(pipe)
      %w(users labels phases).each do |relation|
        if pipe[relation].blank?
          @new_pipe.send(relation).destroy_all
          next
        end
        received = []
        pipe[relation].each do |hash|
          received << hash['id']
          @new_obj = @new_pipe.send(relation).find_by_external_id(hash['id']) || @new_pipe.send(relation).new
          @new_obj.assign_attributes(prepare_hash(hash.dup, (relation == 'phases' ? ['cards', 'pipe_id'] : ['pipe_id'])))
          update_card(hash['cards']) if @new_obj.save && relation == 'phases'
        end

        destroy_non_receiveds(@new_pipe, relation, received)
      end
    end

    def update_card(cards)
      return @new_obj.cards.destroy_all if cards.blank?
      received = []
      cards.each do |card|
        received << card['id']
        new_card = @new_obj.cards.find_by_external_id(card['id']) || @new_obj.cards.new
        new_card.assign_attributes(prepare_hash(card.dup, ['current_phase_id']))
        new_card.save
      end
      destroy_non_receiveds(@new_obj, 'cards', received)
    end

    def prepare_hash(hash, keys_to_delete = [])
      keys_to_delete.each { |key| hash.delete(key) }
      hash.transform_keys { |key| key = (key == 'id' ? 'external_id' : key) }
    end

    def destroy_non_receiveds(instance, relation, received)
      instance.send(relation).all.each do |element|
        element.destroy unless received.include?(element.external_id)
      end
    end
  end
end
