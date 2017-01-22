class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
			t.references :phase
			t.integer :external_id
			t.string  :title
			t.date 	  :due_date
      t.float   :index

      t.timestamps
    end
  end
end
