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
          @new_obj.assign_attributes(prepare_hash(hash.dup, (relation == 'phases' ? ['cards', 'fields', 'pipe_id'] : ['pipe_id'])))
          if @new_obj.save && relation == 'phases'
            update_card(hash['cards'])
            update_fields(hash['fields'])
          end
        end
        destroy_non_receiveds(@new_pipe, relation, received)
      end
    end

    def update_fields(fields)
      return @new_obj.fields.destroy_all if fields.blank?
      received = []
      fields.each do |field|
        received << field['id']
        @new_field = @new_obj.fields.find_by_external_id(field['id']) || @new_obj.fields.new
        @new_field.assign_attributes(prepare_hash(field.select {|item| ['id', 'label', 'description', 'is_title_field'].include?(item)}))
        @new_field.save
      end
      destroy_non_receiveds(@new_obj, 'fields', received)
    end

    def update_card(cards)
      return @new_obj.cards.destroy_all if cards.blank?
      received = []
      cards.each do |card|
        received << card['id']
        @new_card = @new_obj.cards.find_by_external_id(card['id']) || @new_obj.cards.new
        @new_card.assign_attributes(prepare_hash(card.dup, ['current_phase_id', 'field_values']))
        update_field_values(card['field_values']) if @new_card.save
      end
      destroy_non_receiveds(@new_obj, 'cards', received)
    end

    def update_field_values(field_values)
      return @new_card.field_values.destroy_all if field_values.blank?
      received = []
      field_values.each do |field_value|
        received << field_value['id']
        @new_field_value = @new_card.field_values.find_by_external_id(field_value['id']) || @new_card.field_values.new
        @new_field_value.assign_attributes(prepare_hash(field_value.select {|item| ['id', 'value', 'display_value', 'field_id'].include?(item)}, [], true))
        @new_field_value.save
      end
      destroy_non_receiveds(@new_card, 'field_values', received)
    end

    def prepare_hash(hash, keys_to_delete = [], field_value = false)
      keys_to_delete.each { |key| hash.delete(key) }
      hash.transform_keys do |key|
        key = if key == 'id'
          'external_id'
        elsif key == 'field_id' && field_value
          'external_field_id'
        else
          key
        end
      end
    end

    def destroy_non_receiveds(instance, relation, received)
      instance.send(relation).all.each do |element|
        element.destroy unless received.include?(element.external_id)
      end
    end
  end
end
