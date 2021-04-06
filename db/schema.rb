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

ActiveRecord::Schema.define(version: 2021_03_28_181056) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boxes", force: :cascade do |t|
    t.decimal "amount"
    t.decimal "remaining_amount"
    t.date "date_start"
    t.date "expiration_date"
    t.bigint "hormone_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hormone_id"], name: "index_boxes_on_hormone_id"
  end

  create_table "doses", force: :cascade do |t|
    t.bigint "hormone_id"
    t.date "scheduled_date"
    t.decimal "amount"
    t.date "realized_date"
    t.decimal "realized_amount"
    t.string "annotation"
    t.string "status"
    t.date "new_date"
    t.string "apply_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["hormone_id"], name: "index_doses_on_hormone_id"
    t.index ["user_id"], name: "index_doses_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.date "scheduled_date"
    t.string "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "hormones", force: :cascade do |t|
    t.bigint "molecule_id"
    t.string "name"
    t.integer "periodicity"
    t.string "unit"
    t.decimal "unit_per_dose"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["molecule_id"], name: "index_hormones_on_molecule_id"
    t.index ["user_id"], name: "index_hormones_on_user_id"
  end

  create_table "molecules", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.string "author"
    t.string "source"
    t.string "tags", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "image_link"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "boxes", "hormones"
  add_foreign_key "doses", "hormones"
  add_foreign_key "doses", "users"
  add_foreign_key "events", "users"
  add_foreign_key "hormones", "molecules"
  add_foreign_key "hormones", "users"
end
