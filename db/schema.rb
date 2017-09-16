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

ActiveRecord::Schema.define(version: 20170916162921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artist_images", force: :cascade do |t|
    t.string   "tag"
    t.string   "image"
    t.integer  "votes"
    t.integer  "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_artist_images_on_artist_id", using: :btree
  end

  create_table "artist_requests", force: :cascade do |t|
    t.float    "offer_price"
    t.integer  "consumer_event_id"
    t.integer  "artist_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["artist_id"], name: "index_artist_requests_on_artist_id", using: :btree
    t.index ["consumer_event_id"], name: "index_artist_requests_on_consumer_event_id", using: :btree
  end

  create_table "artist_services", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.integer  "artist_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "consumer_request_id"
    t.index ["artist_id"], name: "index_artist_services_on_artist_id", using: :btree
    t.index ["consumer_request_id"], name: "index_artist_services_on_consumer_request_id", using: :btree
  end

  create_table "artists", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "location"
    t.integer  "travel_range"
    t.string   "tags"
    t.text     "bio"
    t.string   "instagram_handle"
    t.time     "avg_response_time"
    t.float    "confirmation_rate"
    t.integer  "rating"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "category"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "photo"
    t.index ["user_id"], name: "index_artists_on_user_id", using: :btree
  end

  create_table "certifications", force: :cascade do |t|
    t.string   "name"
    t.string   "img"
    t.integer  "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_certifications_on_artist_id", using: :btree
  end

  create_table "consumer_events", force: :cascade do |t|
    t.string   "location"
    t.datetime "date"
    t.string   "service"
    t.text     "description"
    t.string   "tags"
    t.float    "budget"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_consumer_events_on_user_id", using: :btree
  end

  create_table "consumer_requests", force: :cascade do |t|
    t.float    "base_price"
    t.float    "fees"
    t.float    "final_price"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "date"
    t.text     "address"
    t.datetime "time"
    t.text     "message"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "artist_id"
    t.string   "servicename"
    t.index ["artist_id"], name: "index_consumer_requests_on_artist_id", using: :btree
    t.index ["user_id"], name: "index_consumer_requests_on_user_id", using: :btree
  end

  create_table "consumers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "city"
    t.string   "profile_img"
    t.string   "instagram"
    t.string   "phone_number"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "last_name"
    t.index ["user_id"], name: "index_consumers_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.string   "subject"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "consumer_request_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["consumer_request_id"], name: "index_transactions_on_consumer_request_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "artist_images", "artists"
  add_foreign_key "artist_requests", "artists"
  add_foreign_key "artist_requests", "consumer_events"
  add_foreign_key "artist_services", "artists"
  add_foreign_key "artist_services", "consumer_requests"
  add_foreign_key "artists", "users"
  add_foreign_key "certifications", "artists"
  add_foreign_key "consumer_events", "users"
  add_foreign_key "consumer_requests", "artists"
  add_foreign_key "consumer_requests", "users"
  add_foreign_key "consumers", "users"
  add_foreign_key "messages", "users"
  add_foreign_key "transactions", "consumer_requests"
end
