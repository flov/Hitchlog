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

ActiveRecord::Schema.define(version: 20190204195250) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "race_id"
  end

  create_table "authentications", force: :cascade do |t|
    t.string   "provider",          limit: 255
    t.string   "uid",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "custom_attributes", limit: 255
    t.integer  "user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "trip_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "country_distances", force: :cascade do |t|
    t.integer "distance"
    t.integer "trip_id"
    t.string  "country",      limit: 255
    t.string  "country_code"
  end

  create_table "future_trips", force: :cascade do |t|
    t.string   "from",              limit: 255
    t.string   "to",                limit: 255
    t.integer  "user_id"
    t.datetime "departure"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "description"
    t.float    "from_lng"
    t.float    "from_lat"
    t.float    "to_lng"
    t.float    "to_lat"
    t.string   "from_city",         limit: 255
    t.string   "from_country_code", limit: 255
    t.string   "from_country",      limit: 255
    t.string   "to_city",           limit: 255
    t.string   "to_country_code",   limit: 255
    t.string   "to_country",        limit: 255
  end

  create_table "people", force: :cascade do |t|
    t.string  "occupation", limit: 255
    t.string  "mission",    limit: 255
    t.string  "origin",     limit: 255
    t.integer "ride_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "trip_id"
    t.string   "photo",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "body",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "races", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "from_location",          limit: 255
    t.string   "to_location",            limit: 255
    t.float    "from_lat"
    t.float    "to_lat"
    t.string   "from_address",           limit: 255
    t.string   "to_address",             limit: 255
    t.string   "from_country",           limit: 255
    t.string   "to_country",             limit: 255
    t.string   "from_city",              limit: 255
    t.string   "to_city",                limit: 255
    t.string   "from_postal_code",       limit: 255
    t.string   "to_postal_code",         limit: 255
    t.string   "from_formatted_address", limit: 255
    t.string   "to_formatted_address",   limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "rides", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.string   "photo_file_size",    limit: 255
    t.string   "photo_updated_at",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "story"
    t.integer  "waiting_time"
    t.datetime "date"
    t.integer  "trip_id"
    t.float    "duration"
    t.integer  "number"
    t.string   "experience",         limit: 255, default: "good"
    t.string   "gender",             limit: 255
    t.string   "photo_caption",      limit: 255
    t.string   "photo",              limit: 255
    t.string   "mission",            limit: 255
    t.string   "vehicle",            limit: 255
    t.string   "youtube",            limit: 11
  end

  add_index "rides", ["experience"], name: "index_rides_on_experience", using: :btree
  add_index "rides", ["gender"], name: "index_rides_on_gender", using: :btree
  add_index "rides", ["number"], name: "index_rides_on_number", using: :btree
  add_index "rides", ["photo_file_name"], name: "index_hitchhikes_on_photo_file_name", using: :btree
  add_index "rides", ["title"], name: "index_rides_on_title", using: :btree
  add_index "rides", ["trip_id"], name: "index_rides_on_trip_id", using: :btree
  add_index "rides", ["vehicle"], name: "index_rides_on_vehicle", using: :btree
  add_index "rides", ["youtube"], name: "index_rides_on_youtube", using: :btree

  create_table "slugs", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "sluggable_id"
    t.integer  "sequence",                   default: 1, null: false
    t.string   "sluggable_type", limit: 40
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], name: "index_slugs_on_n_s_s_and_s", unique: true, using: :btree
  add_index "slugs", ["sluggable_id"], name: "index_slugs_on_sluggable_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context", using: :btree
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count",             default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "trips", force: :cascade do |t|
    t.integer  "distance"
    t.datetime "departure"
    t.string   "from",                   limit: 255
    t.string   "to",                     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "from_country",           limit: 255
    t.string   "to_country",             limit: 255
    t.string   "from_city",              limit: 255
    t.string   "to_city",                limit: 255
    t.integer  "money_spent"
    t.integer  "travelling_with"
    t.datetime "arrival"
    t.float    "to_lng"
    t.float    "to_lat"
    t.float    "from_lng"
    t.float    "from_lat"
    t.string   "from_postal_code",       limit: 255
    t.string   "from_street",            limit: 255
    t.string   "from_street_no",         limit: 255
    t.string   "to_postal_code",         limit: 255
    t.string   "to_street",              limit: 255
    t.string   "to_street_no",           limit: 255
    t.string   "from_formatted_address", limit: 255
    t.string   "to_formatted_address",   limit: 255
    t.text     "route"
    t.integer  "gmaps_duration"
    t.string   "from_country_code",      limit: 255
    t.string   "to_country_code",        limit: 255
  end

  add_index "trips", ["from_country"], name: "index_trips_on_from_country", using: :btree
  add_index "trips", ["to_country"], name: "index_trips_on_to_country", using: :btree
  add_index "trips", ["travelling_with"], name: "index_trips_on_travelling_with", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,                 null: false
    t.string   "encrypted_password",     limit: 128,                 null: false
    t.string   "password_salt",          limit: 255
    t.string   "reset_password_token",   limit: 255
    t.string   "remember_token",         limit: 255
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",               limit: 255
    t.boolean  "admin",                              default: false
    t.string   "gender",                 limit: 255
    t.float    "lat"
    t.float    "lng"
    t.text     "about_you"
    t.string   "cs_user",                limit: 255
    t.string   "city",                   limit: 255
    t.string   "country_code",           limit: 255
    t.string   "country",                limit: 255
    t.string   "location",               limit: 255
    t.datetime "location_updated_at"
    t.date     "date_of_birth"
    t.string   "languages",              limit: 255
    t.string   "origin",                 limit: 255
    t.string   "be_welcome_user",        limit: 255
    t.datetime "reset_password_sent_at"
    t.string   "uid",                    limit: 255
    t.string   "provider",               limit: 255
    t.string   "oauth_token",            limit: 255
    t.time     "oauth_expires_at"
    t.string   "name",                   limit: 255
    t.string   "trustroots"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["country"], name: "index_users_on_country", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["gender"], name: "index_users_on_gender", using: :btree
  add_index "users", ["location"], name: "index_users_on_location", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end
