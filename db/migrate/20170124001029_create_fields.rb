class CreateFields < ActiveRecord::Migration[5.0]
  def change
    create_table :fields do |t|
      t.references :phase
      t.integer :external_id
      t.string :label
      t.string :description
      t.boolean :is_title_field

      t.timestamps
    end
  end
end
