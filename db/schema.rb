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

ActiveRecord::Schema.define(version: 20170111065600) do

  create_table "clients", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "email",       limit: 255
    t.string   "skype",       limit: 255
    t.integer  "position_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "company_id",  limit: 4
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "area_of_interest", limit: 255
    t.text     "description",      limit: 65535
    t.string   "status",           limit: 255
    t.text     "website",          limit: 65535
    t.string   "city",             limit: 255
    t.text     "notes",            limit: 65535
    t.text     "adress",           limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "company_id",   limit: 4
    t.text     "email",        limit: 65535
    t.string   "phone",        limit: 255
    t.boolean  "main_contact"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id",      limit: 4
  end

  create_table "positions", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "area_of_interest",   limit: 255
    t.text     "link",               limit: 65535
    t.string   "city",               limit: 255
    t.integer  "company_id",         limit: 4
    t.integer  "contact_id",         limit: 4
    t.integer  "capacity",           limit: 4
    t.string   "allowance",          limit: 255
    t.boolean  "hiring_opportunity"
    t.text     "description",        limit: 65535
    t.text     "requirements",       limit: 65535
    t.text     "remarks",            limit: 65535
    t.string   "status",             limit: 255
    t.integer  "user_id",            limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.text     "email",           limit: 65535
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

end
