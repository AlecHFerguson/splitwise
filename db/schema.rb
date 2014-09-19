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

ActiveRecord::Schema.define(version: 20140919025158) do

  create_table "expenses", force: true do |t|
    t.integer  "user_id_old"
    t.string   "name"
    t.text     "description"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "tab_id"
  end

  create_table "participants", force: true do |t|
    t.integer  "tab_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "tabs", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "fname",                                                     null: false
    t.string   "lname",                                                     null: false
    t.string   "email",                                                     null: false
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt",            default: "$2a$10$nw5Qj01Lr7BJhMt7c3yHP.", null: false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
