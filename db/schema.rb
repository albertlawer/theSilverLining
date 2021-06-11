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

ActiveRecord::Schema.define(version: 20180225054331) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_masters", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "avaliable_balance", precision: 12, scale: 2
    t.boolean  "status"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "investment_masters", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "amount_invested",  precision: 12, scale: 2
    t.string   "transaction_code"
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal  "client_per",       precision: 5,  scale: 2
    t.decimal  "ref_per",          precision: 5,  scale: 2
    t.boolean  "status"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "payment_tables", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "referer_user_id"
    t.string   "investment_master_code"
    t.decimal  "client_profit",          precision: 12, scale: 2
    t.decimal  "referer_profit",         precision: 12, scale: 2
    t.decimal  "admin_profit",           precision: 12, scale: 2
    t.boolean  "status"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "subject_class"
    t.string   "action"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "permissions_roles", force: :cascade do |t|
    t.integer  "permission_id"
    t.integer  "role_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "referals_masters", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "refered_user_id"
    t.boolean  "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "request_masters", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "customer_number"
    t.string   "network"
    t.string   "trans_type"
    t.string   "voucher_code"
    t.string   "item_desc"
    t.string   "trans_id"
    t.decimal  "amount",          precision: 12, scale: 2
    t.decimal  "total_amount",    precision: 12, scale: 2
    t.boolean  "status"
    t.boolean  "callback_status"
    t.string   "resp_code"
    t.string   "resp_desc"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "system_configs", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.decimal  "value",      precision: 12, scale: 2
    t.boolean  "status"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",               default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.string   "other_names",            default: "", null: false
    t.string   "contact_number",         default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "ref_code",               default: "", null: false
    t.string   "referer_code",           default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "role_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
