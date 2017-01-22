class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
    	t.references :pipe
      t.integer :external_id
    	t.string :name
    	t.string :username
    	t.string :email
    	t.string :display_username

      t.timestamps
    end
  end
end