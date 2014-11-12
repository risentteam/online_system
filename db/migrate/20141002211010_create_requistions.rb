class CreateRequistions < ActiveRecord::Migration
  def change
    create_table "requistions", force: true do |t|
      t.string   "object",                      null: false
      t.datetime "created_at",                  null: false
      t.datetime "updated_at",                  null: false
      t.string   "main_address",                null: false
      t.string   "arrival_address",             null: false
      t.string   "contact_name",                null: false
      t.string   "contact_phone",               null: false
      t.string   "type_requistion", limit: nil, null: false
      t.string   "info"
      t.integer  "contract"
      t.integer  "category"
    end
  end
end
