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

ActiveRecord::Schema.define(version: 20130708125434) do

  create_table "daily_reviews", force: true do |t|
    t.integer  "task_id",                    null: false
    t.date     "date",                       null: false
    t.boolean  "done",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "msg"
  end

  add_index "daily_reviews", ["done"], name: "index_daily_reviews_on_done"
  add_index "daily_reviews", ["task_id", "date"], name: "index_daily_reviews_on_task_id_and_date"
  add_index "daily_reviews", ["task_id", "done"], name: "index_daily_reviews_on_task_id_and_done"
  add_index "daily_reviews", ["task_id"], name: "index_daily_reviews_on_task_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paused",     default: false
  end

  add_index "tasks", ["role_id"], name: "index_tasks_on_role_id"

end
