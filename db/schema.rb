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

ActiveRecord::Schema.define(version: 20170427145910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string  "name"
    t.integer "activity_category_id", null: false
    t.index ["activity_category_id"], name: "index_activities_on_activity_category_id", using: :btree
  end

  create_table "activities_classrooms", id: false, force: :cascade do |t|
    t.integer "activity_id",  null: false
    t.integer "classroom_id", null: false
  end

  create_table "activity_categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "classrooms", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string  "shift"
    t.index ["user_id"], name: "index_classrooms_on_user_id", using: :btree
  end

  create_table "classrooms_messages", id: false, force: :cascade do |t|
    t.integer "classroom_id", null: false
    t.integer "message_id",   null: false
    t.index ["classroom_id", "message_id"], name: "index_classrooms_messages_on_classroom_id_and_message_id", unique: true, using: :btree
  end

  create_table "classrooms_students", id: false, force: :cascade do |t|
    t.integer "classroom_id", null: false
    t.integer "student_id",   null: false
  end

  create_table "clips", force: :cascade do |t|
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "clips_reports", id: false, force: :cascade do |t|
    t.integer "clip_id",   null: false
    t.integer "report_id", null: false
  end

  create_table "message_students", force: :cascade do |t|
    t.integer "message_id", null: false
    t.integer "student_id", null: false
    t.boolean "read"
    t.index ["message_id", "student_id"], name: "index_message_students_on_message_id_and_student_id", unique: true, using: :btree
    t.index ["message_id"], name: "index_message_students_on_message_id", using: :btree
    t.index ["student_id"], name: "index_message_students_on_student_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.text     "text"
    t.integer  "sender_receiver", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "options", force: :cascade do |t|
    t.string  "name"
    t.boolean "multiple"
    t.integer "activity_id", null: false
    t.index ["activity_id"], name: "index_options_on_activity_id", using: :btree
  end

  create_table "professors", force: :cascade do |t|
    t.integer "classroom_id"
    t.string  "name"
    t.index ["classroom_id"], name: "index_professors_on_classroom_id", using: :btree
  end

  create_table "report_notes", force: :cascade do |t|
    t.integer "activity_id", null: false
    t.integer "report_id",   null: false
    t.text    "text"
    t.index ["activity_id"], name: "index_report_notes_on_activity_id", using: :btree
    t.index ["report_id"], name: "index_report_notes_on_report_id", using: :btree
  end

  create_table "reports", force: :cascade do |t|
    t.integer  "student_id", null: false
    t.date     "date"
    t.boolean  "draft"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id", "date"], name: "index_reports_on_student_id_and_date", unique: true, using: :btree
    t.index ["student_id"], name: "index_reports_on_student_id", using: :btree
  end

  create_table "reports_suboptions", id: false, force: :cascade do |t|
    t.integer "report_id",    null: false
    t.integer "suboption_id", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "schools", force: :cascade do |t|
    t.string  "name",    null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_schools_on_user_id", using: :btree
  end

  create_table "student_users", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "user_id",    null: false
    t.index ["student_id"], name: "index_student_users_on_student_id", using: :btree
    t.index ["user_id"], name: "index_student_users_on_user_id", using: :btree
  end

  create_table "students", force: :cascade do |t|
    t.string   "name",                null: false
    t.string   "address"
    t.date     "birthday"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "suboptions", force: :cascade do |t|
    t.string  "name"
    t.integer "option_id"
    t.index ["option_id"], name: "index_suboptions_on_option_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string  "name",            null: false
    t.string  "phone"
    t.string  "email",           null: false
    t.string  "password_digest", null: false
    t.integer "role_id",         null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["role_id"], name: "index_users_on_role_id", using: :btree
  end

  add_foreign_key "activities", "activity_categories", on_delete: :cascade
  add_foreign_key "activities_classrooms", "activities", on_delete: :cascade
  add_foreign_key "activities_classrooms", "classrooms", on_delete: :cascade
  add_foreign_key "classrooms", "users", on_delete: :nullify
  add_foreign_key "classrooms_messages", "classrooms", on_delete: :cascade
  add_foreign_key "classrooms_messages", "messages", on_delete: :cascade
  add_foreign_key "classrooms_students", "classrooms", on_delete: :cascade
  add_foreign_key "classrooms_students", "students", on_delete: :cascade
  add_foreign_key "clips_reports", "clips", on_delete: :cascade
  add_foreign_key "clips_reports", "reports", on_delete: :cascade
  add_foreign_key "message_students", "messages", on_delete: :cascade
  add_foreign_key "message_students", "students", on_delete: :cascade
  add_foreign_key "options", "activities", on_delete: :cascade
  add_foreign_key "professors", "classrooms", on_delete: :nullify
  add_foreign_key "report_notes", "activities", on_delete: :cascade
  add_foreign_key "report_notes", "reports", on_delete: :cascade
  add_foreign_key "reports", "students", on_delete: :cascade
  add_foreign_key "reports_suboptions", "reports", on_delete: :cascade
  add_foreign_key "reports_suboptions", "suboptions", on_delete: :cascade
  add_foreign_key "schools", "users", on_delete: :restrict
  add_foreign_key "student_users", "students", on_delete: :cascade
  add_foreign_key "student_users", "users", on_delete: :cascade
  add_foreign_key "suboptions", "options", on_delete: :cascade
end
