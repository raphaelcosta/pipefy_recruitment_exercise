class CreateFieldValues < ActiveRecord::Migration[5.0]
  def change
    create_table :field_values do |t|
      t.references :card
      t.integer :external_id
      t.string  :value
      t.string  :display_value
      t.integer :external_field_id

      t.timestamps
    end
  end
end
