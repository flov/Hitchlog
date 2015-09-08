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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150908093518) do

  create_table "assignments", :force => true do |t|
    t.integer "user_id"
    t.integer "race_id"
  end

  create_table "authentications", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "custom_attributes"
    t.integer  "user_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "trip_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "country_distances", :force => true do |t|
    t.integer "distance"
    t.integer "trip_id"
    t.string  "country"
  end

  create_table "future_trips", :force => true do |t|
    t.string   "from"
    t.string   "to"
    t.integer  "user_id"
    t.datetime "departure"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.text     "description"
    t.float    "from_lng"
    t.float    "from_lat"
    t.float    "to_lng"
    t.float    "to_lat"
    t.string   "from_city"
    t.string   "from_country_code"
    t.string   "from_country"
    t.string   "to_city"
    t.string   "to_country_code"
    t.string   "to_country"
  end

  create_table "people", :force => true do |t|
    t.string  "occupation"
    t.string  "mission"
    t.string  "origin"
    t.integer "ride_id"
  end

  create_table "photos", :force => true do |t|
    t.integer  "trip_id"
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "races", :force => true do |t|
    t.string   "name"
    t.string   "from_location"
    t.string   "to_location"
    t.float    "from_lat"
    t.float    "to_lat"
    t.string   "from_address"
    t.string   "to_address"
    t.string   "from_country"
    t.string   "to_country"
    t.string   "from_city"
    t.string   "to_city"
    t.string   "from_postal_code"
    t.string   "to_postal_code"
    t.string   "from_formatted_address"
    t.string   "to_formatted_address"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "rides", :force => true do |t|
    t.string   "title"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.string   "photo_file_size"
    t.string   "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "story"
    t.integer  "waiting_time"
    t.datetime "date"
    t.integer  "trip_id"
    t.float    "duration"
    t.integer  "number"
    t.string   "experience",         :default => "positive"
    t.string   "gender"
    t.string   "photo_caption"
    t.string   "photo"
    t.string   "mission"
    t.string   "vehicle"
  end

  add_index "rides", ["experience"], :name => "index_rides_on_experience"
  add_index "rides", ["gender"], :name => "index_rides_on_gender"
  add_index "rides", ["number"], :name => "index_rides_on_number"
  add_index "rides", ["photo_file_name"], :name => "index_hitchhikes_on_photo_file_name"
  add_index "rides", ["title"], :name => "index_rides_on_title"
  add_index "rides", ["trip_id"], :name => "index_rides_on_trip_id"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "trips", :force => true do |t|
    t.integer  "distance"
    t.datetime "departure"
    t.string   "from"
    t.string   "to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "from_country"
    t.string   "to_country"
    t.string   "from_city"
    t.string   "to_city"
    t.integer  "money_spent"
    t.integer  "travelling_with"
    t.datetime "arrival"
    t.float    "to_lng"
    t.float    "to_lat"
    t.float    "from_lng"
    t.float    "from_lat"
    t.string   "from_postal_code"
    t.string   "from_street"
    t.string   "from_street_no"
    t.string   "to_postal_code"
    t.string   "to_street"
    t.string   "to_street_no"
    t.string   "from_formatted_address"
    t.string   "to_formatted_address"
    t.text     "route"
    t.integer  "gmaps_duration"
    t.string   "from_country_code"
    t.string   "to_country_code"
  end

  add_index "trips", ["from_country"], :name => "index_trips_on_from_country"
  add_index "trips", ["to_country"], :name => "index_trips_on_to_country"
  add_index "trips", ["travelling_with"], :name => "index_trips_on_travelling_with"

  create_table "users", :force => true do |t|
    t.string   "email",                                                    :null => false
    t.string   "encrypted_password",     :limit => 128,                    :null => false
    t.string   "password_salt"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.boolean  "admin",                                 :default => false
    t.string   "gender"
    t.float    "lat"
    t.float    "lng"
    t.text     "about_you"
    t.string   "cs_user"
    t.string   "city"
    t.string   "country_code"
    t.string   "country"
    t.string   "location"
    t.datetime "location_updated_at"
    t.date     "date_of_birth"
    t.string   "languages"
    t.string   "origin"
    t.string   "be_welcome_user"
    t.datetime "reset_password_sent_at"
    t.string   "uid"
    t.string   "provider"
    t.string   "oauth_token"
    t.time     "oauth_expires_at"
    t.string   "name"
  end

  add_index "users", ["country"], :name => "index_users_on_country"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["location"], :name => "index_users_on_location"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username"

end
