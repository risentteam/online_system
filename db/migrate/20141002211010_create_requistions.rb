class CreateRequistions < ActiveRecord::Migration
  def change
    create_table "requistions", force: true do |t|
      t.string   "object",                      null: false
<<<<<<< HEAD
      t.integer  "status"
=======
      t.integer  "status", default: 0
>>>>>>> c6fb0878f4d9213b033f4d65bd2cd0e0d5fbf834
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
