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

ActiveRecord::Schema.define(:version => 20121023040641) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "checkins", :force => true do |t|
    t.integer  "restaurant_id"
    t.integer  "table_id"
    t.integer  "user_id"
    t.string   "type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "table_seqeucne"
    t.datetime "arrive_at"
    t.datetime "leave_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "cuisines", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "dish_to_tags", :force => true do |t|
    t.integer "dish_id"
    t.integer "tag_id"
  end

  create_table "dishes", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.float    "price"
    t.string   "primary_image"
    t.string   "type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "restaurant_id"
  end

  create_table "employments", :force => true do |t|
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.string   "type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "order_lines", :force => true do |t|
    t.integer  "dish_id"
    t.integer  "user_id"
    t.float    "price"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "order_id"
  end

  add_index "order_lines", ["order_id"], :name => "fki_order_id"

  create_table "orders", :force => true do |t|
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.integer  "table_id"
    t.float    "price"
    t.float    "tax"
    t.float    "tip"
    t.float    "total"
    t.string   "status"
    t.integer  "waiter_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.float    "discount"
  end

  add_index "orders", ["user_id"], :name => "fki_user_id"
  add_index "orders", ["waiter_id"], :name => "fki_waiter_id"

  create_table "postal_addresses", :force => true do |t|
    t.string   "street"
    t.string   "locality"
    t.string   "region"
    t.string   "country"
    t.string   "postal_code"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "restaurant_id"
  end

  add_index "postal_addresses", ["restaurant_id"], :name => "fki_restaurant_fkey"

  create_table "restaurant_to_tags", :force => true do |t|
    t.integer "restaurant_id"
    t.integer "tag_id"
  end

  create_table "restaurants", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "open_hours"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.boolean  "is_active"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "primary_image"
    t.integer  "company_id"
    t.string   "google_id"
    t.string   "url",            :limit => 1000
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "region"
    t.string   "country"
    t.string   "postal_code"
    t.string   "status"
    t.string   "street_address"
    t.string   "google_ref"
    t.float    "google_rating"
  end

  add_index "restaurants", ["company_id"], :name => "fki_company_id"
  add_index "restaurants", ["google_id"], :name => "google_id_index"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "tables", :force => true do |t|
    t.string   "name"
    t.integer  "sequence"
    t.integer  "num_seats"
    t.string   "shape"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "restaurant_id"
  end

  add_index "tables", ["restaurant_id"], :name => "fki_restaurant_to_table"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "type"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
