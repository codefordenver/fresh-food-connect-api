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

ActiveRecord::Schema.define(version: 20151011162154) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "donation_tokens", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "expires_at"
    t.datetime "used_at"
    t.integer  "donation_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
  end

  add_index "donation_tokens", ["token"], name: "index_donation_tokens_on_token", using: :btree

  create_table "donations", force: :cascade do |t|
    t.integer  "size",        null: false
    t.text     "comments"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "location_id", null: false
    t.integer  "user_id",     null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "address",     default: "", null: false
    t.string   "city",        default: "", null: false
    t.string   "state",       default: "", null: false
    t.string   "zipcode",     default: "", null: false
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id"
    t.date     "pickup_date"
    t.text     "comments"
    t.text     "extra"
    t.integer  "pickup_day"
  end

  add_index "locations", ["user_id"], name: "index_locations_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first",                  default: ""
    t.string   "last",                   default: ""
    t.string   "email",                  default: ""
    t.integer  "role"
    t.string   "phone",                  default: ""
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.json     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  add_foreign_key "donations", "locations"
  add_foreign_key "donations", "users"
  add_foreign_key "locations", "users"
end
