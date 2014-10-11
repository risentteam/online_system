# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141011181415) do

  create_table "bosses", force: true do |t|
    t.string "name"
  end

  create_table "contracts", primary_key: "contract_id", force: true do |t|
    t.string   "company"
    t.datetime "period_contract"
    t.integer  "user_id"
  end

  create_table "pairs", force: true do |t|
    t.integer  "user_id",       null: false
    t.integer  "requistion_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "requistions", force: true do |t|
    t.string   "object",                      null: false
    t.string   "status"
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

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.integer  "type"
    t.integer  "boss_id",         default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "workers", force: true do |t|
    t.string   "name"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "boss_id"
    t.string   "type_worker", limit: nil
    t.integer  "user_id"
  end

end
