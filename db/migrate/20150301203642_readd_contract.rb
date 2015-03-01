class ReaddContract < ActiveRecord::Migration
  def change
    create_table "contracts", force: true do |t|
      t.datetime "date_of_signing"
      t.integer  "user_id"
      t.string 'comment'
      t.string 'description'
      t.string 'name_contract'
      t.datetime "end_time"
      t.datetime "brgin_time"      
  end
end
