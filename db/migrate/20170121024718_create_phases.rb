class CreatePhases < ActiveRecord::Migration[5.0]
  def change
    create_table :phases do |t|
			t.references :pipe
			t.integer 	 :external_id
			t.string 		 :name
			t.string 		 :description
			t.boolean 	 :done
			t.float 		 :index
			t.boolean 	 :draft

      t.timestamps
    end
  end
end