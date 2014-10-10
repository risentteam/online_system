class CreateWorker < ActiveRecord::Migration
  def change
    create_table "workers", force: true do |t|
      t.string   "name"
      t.datetime "created_at",              null: false
      t.datetime "updated_at",              null: false
      t.integer  "boss_id"
      t.string   "type_worker", limit: nil
      t.integer  "user_id"
    end
  end
end
