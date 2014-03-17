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

ActiveRecord::Schema.define(version: 20140312100338) do

  create_table "events", force: true do |t|
    t.string   "url"
    t.date     "event_date"
    t.string   "title"
    t.string   "place"
    t.string   "address"
    t.integer  "price"
    t.integer  "capacity"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "cat_beginner_flg"
    t.boolean  "cat_pro_flg"
    t.boolean  "cat_weekday_flg"
    t.boolean  "cat_holiday_flg"
    t.boolean  "cat_allnight_flg"
    t.integer  "prefecture_id"
  end

end
