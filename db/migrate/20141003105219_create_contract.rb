class AddColumnType < ActiveRecord::Migration
  def change
    create_table "contracts", force: true do |t|
      t.integer  "contract_id"
      t.string   "company"
      t.datetime "period_contract"
      t.integer  "user_id"
    end
  end
end
