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

ActiveRecord::Schema.define(version: 20180304162942) do

  create_table "analysts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_analysts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_analysts_on_reset_password_token", unique: true
  end

  create_table "backofficers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_backofficers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_backofficers_on_reset_password_token", unique: true
  end

  create_table "incidents", force: :cascade do |t|
    t.integer "analyst_id"
    t.integer "backofficer_id"
    t.integer "problem_kind", default: 0
    t.integer "priority_level", default: 0
    t.string "description"
    t.string "user_email"
    t.string "title"
    t.integer "status", default: 0
    t.string "solution_description"
    t.string "analysis_time"
    t.string "solution_time"
    t.string "entity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "evidence_screen_file_name"
    t.string "evidence_screen_content_type"
    t.integer "evidence_screen_file_size"
    t.datetime "evidence_screen_updated_at"
    t.index ["analyst_id"], name: "index_incidents_on_analyst_id"
    t.index ["backofficer_id"], name: "index_incidents_on_backofficer_id"
  end

end
