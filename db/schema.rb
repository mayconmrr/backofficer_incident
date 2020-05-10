# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_10_013850) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_analysts_on_confirmation_token", unique: true
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_backofficers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_backofficers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_backofficers_on_reset_password_token", unique: true
  end

  create_table "incidents", force: :cascade do |t|
    t.bigint "analyst_id"
    t.bigint "backofficer_id"
    t.string "problem_kind", default: "bug_system"
    t.string "priority_level", default: "low"
    t.string "problem_description"
    t.string "pending_description"
    t.string "solution_description"
    t.string "reopened_description"
    t.string "user_email"
    t.string "contract_id"
    t.string "title"
    t.string "status", default: "open"
    t.string "analysis_time"
    t.datetime "analysis_started_at"
    t.datetime "solved_at"
    t.string "entity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "evidence_screen_file_name"
    t.string "evidence_screen_content_type"
    t.bigint "evidence_screen_file_size"
    t.datetime "evidence_screen_updated_at"
    t.string "plataform_kind"
    t.string "captured_by"
    t.string "pending_reason"
    t.string "reopening_description"
    t.boolean "incident_reopened", default: false
    t.string "reopened_by"
    t.string "user_name"
    t.index ["analyst_id"], name: "index_incidents_on_analyst_id"
    t.index ["backofficer_id"], name: "index_incidents_on_backofficer_id"
  end

end
