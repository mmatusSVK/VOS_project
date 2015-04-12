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

ActiveRecord::Schema.define(version: 20150412084009) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.text     "answer_name", null: false
    t.boolean  "is_right"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "current_tests", force: :cascade do |t|
    t.integer  "topic_id"
    t.integer  "test_id"
    t.integer  "questions_count"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text     "question_name", null: false
    t.integer  "topic_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "tests", force: :cascade do |t|
    t.string   "test_name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string   "topic_name"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "information"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "login_name"
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "current_tests", "tests"
  add_foreign_key "current_tests", "topics"
  add_foreign_key "questions", "topics"
  add_foreign_key "tests", "users"
  add_foreign_key "topics", "users"
end
