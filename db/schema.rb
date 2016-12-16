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

ActiveRecord::Schema.define(version: 20161121170303) do

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
    t.string "name"
    t.string "shift"
  end

  create_table "classrooms_professors", id: false, force: :cascade do |t|
    t.integer "classroom_id", null: false
    t.integer "professor_id", null: false
  end

  create_table "classrooms_students", id: false, force: :cascade do |t|
    t.integer "classroom_id", null: false
    t.integer "student_id",   null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "professor_id", null: false
    t.string   "text"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["professor_id"], name: "index_messages_on_professor_id", using: :btree
  end

  create_table "messages_students", id: false, force: :cascade do |t|
    t.integer "message_id", null: false
    t.integer "student_id", null: false
  end

  create_table "option_students", force: :cascade do |t|
    t.integer  "student_id", null: false
    t.integer  "option_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_id"], name: "index_option_students_on_option_id", using: :btree
    t.index ["student_id"], name: "index_option_students_on_student_id", using: :btree
  end

  create_table "options", force: :cascade do |t|
    t.string  "name"
    t.integer "activity_id", null: false
    t.index ["activity_id"], name: "index_options_on_activity_id", using: :btree
  end

  create_table "professors", force: :cascade do |t|
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_professors_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "schools", force: :cascade do |t|
    t.string  "name"
    t.integer "professor_id", null: false
    t.index ["professor_id"], name: "index_schools_on_professor_id", using: :btree
  end

  create_table "student_users", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "user_id",    null: false
    t.index ["student_id"], name: "index_student_users_on_student_id", using: :btree
    t.index ["user_id"], name: "index_student_users_on_user_id", using: :btree
  end

  create_table "students", force: :cascade do |t|
    t.string "name",     null: false
    t.string "address"
    t.date   "birthday"
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

end
