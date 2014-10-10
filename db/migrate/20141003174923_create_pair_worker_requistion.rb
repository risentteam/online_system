class ChangeTypeType < ActiveRecord::Migration
  def change
    create_table "pair_worker_requistions", force: true do |t|
      t.integer  "id_worker",     null: false
      t.integer  "id_requistion", null: false
      t.datetime "created_at",    null: false
      t.datetime "updated_at",    null: false
    end
  end
end
