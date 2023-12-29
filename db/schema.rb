# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_29_033758) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "firestore_battle_plans", force: :cascade do |t|
    t.bigint "firestore_user_id"
    t.string "quarter"
    t.date "start_date"
    t.json "calibration_data"
    t.json "connection_data"
    t.json "condition_data"
    t.json "contribution_data"
    t.integer "calibration_success_days"
    t.integer "connection_success_days"
    t.integer "condition_success_days"
    t.integer "contribution_success_days"
    t.integer "calibration_percentage"
    t.integer "connection_percentage"
    t.integer "condition_percentage"
    t.integer "contribution_percentage"
    t.integer "total_days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["firestore_user_id"], name: "index_firestore_battle_plans_on_firestore_user_id"
  end

  create_table "firestore_users", force: :cascade do |t|
    t.string "firestore_id"
    t.string "name"
    t.string "email"
    t.string "team_id"
    t.string "team_name"
    t.integer "age"
    t.string "image_url"
    t.string "iron_council_email"
    t.string "phone"
    t.string "zip_code"
    t.string "gender"
    t.datetime "start_date"
    t.string "plan_url"
    t.string "status"
    t.datetime "account_created_at", precision: nil
    t.bigint "podio_team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["podio_team_id"], name: "index_firestore_users_on_podio_team_id"
  end

  create_table "podio_battle_teams", force: :cascade do |t|
    t.string "name"
    t.string "team_hash"
    t.bigint "team_id"
    t.text "members_array", default: [], array: true
    t.string "team_type"
    t.boolean "pending_processing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "podio_members", force: :cascade do |t|
    t.bigint "podio_member_id"
    t.bigint "podio_team_id"
    t.string "podio_team_name"
    t.string "iron_council_email"
    t.string "full_name"
    t.string "first_name"
    t.string "last_name"
    t.string "status"
    t.string "email"
    t.boolean "pending_processing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
