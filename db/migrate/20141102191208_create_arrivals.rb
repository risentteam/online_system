class CreateArrivals < ActiveRecord::Migration
  def change
		create_table :arrivals do |t|
			t.integer  "id_user", null: false
      t.integer  "id_building", null: false
      t.integer  "type"
      t.datetime "time",    null: false
			t.timestamps
		end
  end
end
