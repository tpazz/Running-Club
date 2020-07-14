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

ActiveRecord::Schema.define(version: 2019_05_11_150918) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.bigint "schedule_id"
    t.bigint "child_id"
    t.integer "attended"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_attendances_on_child_id"
    t.index ["schedule_id"], name: "index_attendances_on_schedule_id"
  end

  create_table "button_clicks", force: :cascade do |t|
    t.bigint "child_id"
    t.bigint "schedule_id"
    t.bigint "coach_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_button_clicks_on_child_id"
    t.index ["coach_id"], name: "index_button_clicks_on_coach_id"
    t.index ["schedule_id"], name: "index_button_clicks_on_schedule_id"
  end

  create_table "children", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "parent_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "gender"
    t.date "date_of_birth", null: false
    t.integer "photo", default: 0
    t.integer "inactive_days", default: 0
    t.string "medical_issues"
    t.boolean "collected"
    t.boolean "paid", default: false
    t.string "doctor_name"
    t.string "doctor_address"
    t.string "doctor_postcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_children_on_group_id"
    t.index ["parent_id"], name: "index_children_on_parent_id"
  end

  create_table "coaches", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "telephone"
    t.boolean "appl_status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_coaches_on_user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "documents", force: :cascade do |t|
    t.bigint "coach_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", null: false
    t.date "expiration"
    t.text "description"
    t.index ["coach_id"], name: "index_documents_on_coach_id"
  end

  create_table "emergency_contacts", force: :cascade do |t|
    t.bigint "child_id", null: false
    t.string "phone", null: false
    t.string "relationship"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_emergency_contacts_on_child_id"
  end

  create_table "events", force: :cascade do |t|
    t.date "date"
    t.string "name"
    t.boolean "series"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "galleries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.bigint "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "groups", force: :cascade do |t|
    t.string "group_name"
    t.string "group_colour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "inactive", default: false
  end

  create_table "injury_records", force: :cascade do |t|
    t.bigint "child_id"
    t.string "injury"
    t.bigint "schedule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "parent_notified", default: false
    t.index ["child_id"], name: "index_injury_records_on_child_id"
    t.index ["schedule_id"], name: "index_injury_records_on_schedule_id"
  end

  create_table "mail_models", force: :cascade do |t|
    t.string "mail"
    t.text "message"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parents", force: :cascade do |t|
    t.string "address"
    t.string "postcode"
    t.string "home_number"
    t.string "prime_mobile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.bigint "parent_id", null: false
    t.string "phone_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_phone_numbers_on_parent_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "group_id"
    t.datetime "start_time"
    t.string "location"
    t.string "session_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_schedules_on_group_id"
  end

  create_table "session_helpers", force: :cascade do |t|
    t.bigint "schedule_id"
    t.bigint "coach_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "team_leader", default: false
    t.index ["coach_id"], name: "index_session_helpers_on_coach_id"
    t.index ["schedule_id"], name: "index_session_helpers_on_schedule_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "s_email"
    t.bigint "parents_id"
    t.bigint "coaches_id"
    t.index ["coaches_id"], name: "index_users_on_coaches_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["parents_id"], name: "index_users_on_parents_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attendances", "children"
  add_foreign_key "attendances", "schedules"
  add_foreign_key "button_clicks", "children"
  add_foreign_key "button_clicks", "coaches"
  add_foreign_key "button_clicks", "schedules"
  add_foreign_key "children", "groups"
  add_foreign_key "children", "parents"
  add_foreign_key "coaches", "users"
  add_foreign_key "documents", "coaches"
  add_foreign_key "emergency_contacts", "children"
  add_foreign_key "injury_records", "children"
  add_foreign_key "injury_records", "schedules"
  add_foreign_key "parents", "users"
  add_foreign_key "phone_numbers", "parents"
  add_foreign_key "schedules", "groups"
  add_foreign_key "session_helpers", "coaches"
  add_foreign_key "session_helpers", "schedules"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "users", "coaches", column: "coaches_id"
  add_foreign_key "users", "parents", column: "parents_id"
end
