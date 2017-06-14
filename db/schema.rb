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

ActiveRecord::Schema.define(version: 20170517084240) do

  create_table "animals", force: :cascade do |t|
    t.string   "animal_type"
    t.integer  "age"
    t.string   "sex"
    t.text     "location"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "race_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "animal_state"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "animals", ["race_id"], name: "index_animals_on_race_id"
  add_index "animals", ["user_id"], name: "index_animals_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.text     "description"
    t.integer  "animal_id"
    t.integer  "pet_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "comments", ["animal_id"], name: "index_comments_on_animal_id"
  add_index "comments", ["pet_id"], name: "index_comments_on_pet_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "devices", force: :cascade do |t|
    t.string   "user_agent"
    t.string   "endpoint"
    t.string   "p256dh"
    t.string   "auth"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id"

  create_table "events", force: :cascade do |t|
    t.text     "title"
    t.text     "description"
    t.date     "date_event"
    t.text     "location"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "images", force: :cascade do |t|
    t.text     "link"
    t.integer  "animal_id"
    t.integer  "pet_id"
    t.integer  "event_id"
    t.integer  "information_id"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "images", ["animal_id"], name: "index_images_on_animal_id"
  add_index "images", ["event_id"], name: "index_images_on_event_id"
  add_index "images", ["information_id"], name: "index_images_on_information_id"
  add_index "images", ["pet_id"], name: "index_images_on_pet_id"
  add_index "images", ["user_id"], name: "index_images_on_user_id"

  create_table "information", force: :cascade do |t|
    t.text     "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "information", ["user_id"], name: "index_information_on_user_id"

  create_table "notifications", force: :cascade do |t|
    t.string  "titulo"
    t.text    "mensaje"
    t.string  "url"
    t.boolean "seen"
    t.integer "user_id"
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "pets", force: :cascade do |t|
    t.string   "animal_type"
    t.string   "sex"
    t.string   "name"
    t.text     "description"
    t.date     "lost_on"
    t.text     "lost_in"
    t.integer  "user_id"
    t.integer  "race_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "animal_state"
  end

  add_index "pets", ["race_id"], name: "index_pets_on_race_id"
  add_index "pets", ["user_id"], name: "index_pets_on_user_id"

  create_table "races", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "sex"
    t.integer  "role_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["role_id"], name: "index_users_on_role_id"

end
