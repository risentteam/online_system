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

ActiveRecord::Schema.define(version: 20141011104000) do

  create_table "bosses", force: true do |t|
    t.string "name"
  end

  create_table "buildings", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "linkQR"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contracts", force: true do |t|
    t.integer  "contract_id"
    t.string   "company"
    t.datetime "period_contract"
    t.integer  "user_id"
  end

  create_table "pair_worker_requistions", force: true do |t|
    t.integer  "id_worker",     null: false
    t.integer  "id_requistion", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "requistions", force: true do |t|
    t.string   "object",          null: false
    t.string   "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "main_address",    null: false
    t.string   "arrival_address", null: false
    t.string   "contact_name",    null: false
    t.string   "contact_phone",   null: false
    t.string   "type_requistion", null: false
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "workers", force: true do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "boss_id"
    t.string   "type_worker"
    t.integer  "user_id"
  end

end
