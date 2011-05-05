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

ActiveRecord::Schema.define(:version => 20110422065549) do

  create_table "consumer_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",       :limit => 30
    t.string   "token",      :limit => 1024
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "consumer_tokens", ["token"], :name => "index_consumer_tokens_on_token", :unique => true

  create_table "hours", :force => true do |t|
    t.datetime "date"
    t.datetime "start"
    t.string   "location"
    t.integer  "number_slots"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "synced",       :default => false
    t.integer  "user_id"
  end

  create_table "slots", :force => true do |t|
    t.datetime "start"
    t.datetime "end"
    t.string   "email"
    t.boolean  "bookstatus", :default => false
    t.integer  "hour_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "synced",     :default => false
  end

  add_index "slots", ["hour_id"], :name => "index_slots_on_hour_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "oauth_token"
    t.string   "oauth_secret"
  end

end
