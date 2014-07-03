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

ActiveRecord::Schema.define(version: 20140702065534) do

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

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "domain"
    t.float    "no_of_sprints"
    t.integer  "price_per_sprint"
    t.string   "quotation_no"
    t.date     "date_started"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
