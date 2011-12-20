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

ActiveRecord::Schema.define(:version => 20110606075755) do

  create_table "attachments", :force => true do |t|
    t.integer  "refId"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pad_id"
  end

  create_table "conversations", :force => true do |t|
    t.string   "topic"
    t.integer  "pad_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "events", :force => true do |t|
    t.integer  "event_type"
    t.string   "description"
    t.integer  "source_id"
    t.string   "source_name"
    t.integer  "source_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link"
    t.integer  "organization_id"
  end

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.integer  "conversation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "user_name"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "subdomain"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pads", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pad_id"
    t.boolean  "published"
  end

  create_table "permissions", :force => true do |t|
    t.integer  "pad_id"
    t.integer  "user_id"
    t.boolean  "send_email_events"
    t.boolean  "show_dashboard_events"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image_name"
    t.integer  "organization_id"
  end

end
