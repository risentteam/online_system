class CreateArrivals < ActiveRecord::Migration
	def change
		create_table :arrivals do |t|
			t.integer  "user_id", null: false
			t.integer  "building_id", null: false
			t.integer  "check_type", defaul: 0
			t.datetime "time",    null: false
			t.timestamps
		end
	end
end
