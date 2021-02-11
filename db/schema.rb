# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120829001358) do

  create_table "controllers_and_actions", :force => true do |t|
    t.string   "name"
    t.string   "controller"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "detours", :force => true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.string   "route"
    t.integer  "direction"
    t.integer  "detour_type"
    t.text     "description"
    t.string   "supervisor"
    t.string   "dispatcher"
    t.string   "reason"
    t.string   "create_addr"
    t.string   "create_pdf_path"
    t.string   "cancel_pdf_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "cancel_addr"
    t.integer  "canceled"
    t.datetime "cancel_date"
    t.string   "bulletin_number"
    t.string   "change_addr"
    t.datetime "change_at"
    t.string   "change_pdf_path"
  end

  create_table "locations", :force => true do |t|
    t.string   "short_name"
    t.string   "long_name"
    t.string   "fax_number"
    t.integer  "fax_default"
    t.string   "phone_number"
    t.integer  "phone_default"
    t.string   "email_address"
    t.string   "printer"
    t.integer  "printer_default"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "email_default"
    t.integer  "printer_is_postscript"
    t.integer  "notify_by_default"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "detour_id"
    t.integer  "location_id"
    t.string   "notification_type"
    t.string   "notification_method"
    t.integer  "acknowledge_requested"
    t.datetime "last_attempt"
    t.integer  "delivered"
    t.datetime "acknowledged_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rights", :force => true do |t|
    t.string "name"
    t.string "controller"
    t.string "action"
  end

  create_table "rights_roles", :id => false, :force => true do |t|
    t.integer "right_id"
    t.integer "role_id"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "parameter"
  end

  create_table "stops", :force => true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "direction"
    t.text     "description"
    t.string   "supervisor"
    t.string   "dispatcher"
    t.string   "reason"
    t.string   "create_addr"
    t.string   "create_pdf_path"
    t.string   "cancel_addr"
    t.integer  "canceled"
    t.datetime "cancel_date"
    t.string   "cancel_pdf_path"
    t.string   "change_addr"
    t.string   "change_pdf_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "change_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.string   "salt"
    t.integer  "access_level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
  end

end
