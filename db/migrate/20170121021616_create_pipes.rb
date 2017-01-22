class CreatePipes < ActiveRecord::Migration[5.0]
  def change
    create_table :pipes do |t|
    	t.references :organization
    	t.integer :external_id
    	t.string :name
    	t.string :token
    	t.boolean :can_edit
    	t.timestamps
    end
  end
end
