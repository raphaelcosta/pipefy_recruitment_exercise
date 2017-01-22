class CreateLabels < ActiveRecord::Migration[5.0]
  def change
    create_table :labels do |t|
      t.references :pipe
      t.integer :external_id
      t.string :name
      t.string :color
      t.timestamps
    end
  end
end
