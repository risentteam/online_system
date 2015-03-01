class ReaddContracts < ActiveRecord::Migration
  def change
    create_table "contracts", force: true do |t|
      t.string  "comment"
      t.string   "description"
      t.string "name_contract"
      t.integer  "user_id"
      t.datetime 'date_of_signing'
      t.datetime 'end_time'
      t.datetime 'begin_time'
    	end
	end
end
