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

ActiveRecord::Schema.define(version: 20140710032205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: true do |t|
    t.string   "phone"
    t.string   "email"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_name"
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "designation"
  end

  create_table "coders_projects", force: true do |t|
    t.integer "project_id"
    t.integer "coder_id"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "domain"
    t.float    "no_of_sprints"
    t.integer  "price_per_sprint"
    t.string   "quotation_no"
    t.date     "date_started"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
  end

  add_index "projects", ["client_id"], name: "index_projects_on_client_id", using: :btree

  create_table "schedules", force: true do |t|
    t.date     "date"
    t.integer  "hours",      default: 8
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "coder_id"
    t.integer  "project_id"
  end

  add_index "schedules", ["coder_id"], name: "index_schedules_on_coder_id", using: :btree
  add_index "schedules", ["project_id"], name: "index_schedules_on_project_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_admin",               default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
