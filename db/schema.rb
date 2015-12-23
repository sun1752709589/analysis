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

ActiveRecord::Schema.define(version: 20151222075809) do

  create_table "bulbs", force: :cascade do |t|
    t.integer  "device_ip",   limit: 4
    t.string   "op_code",     limit: 255
    t.string   "instruction", limit: 255
    t.string   "care_word",   limit: 255
    t.string   "message",     limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "bulbs", ["created_at"], name: "index_bulbs_on_created_at", using: :btree

  create_table "error_counts", force: :cascade do |t|
    t.string   "error_type",  limit: 255
    t.integer  "error_count", limit: 4
    t.string   "file_path",   limit: 255
    t.string   "key_word",    limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "router_offlines", force: :cascade do |t|
    t.integer  "device_ip",  limit: 4
    t.string   "msg",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "vanke_device_house_tables", force: :cascade do |t|
    t.integer  "device_id",   limit: 4
    t.string   "device_type", limit: 255
    t.integer  "house_id",    limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "vanke_device_usages", force: :cascade do |t|
    t.integer  "device_id",   limit: 4
    t.integer  "device_ip",   limit: 4
    t.string   "device_type", limit: 255
    t.string   "method",      limit: 255
    t.string   "operation",   limit: 255
    t.string   "request_url", limit: 255
    t.string   "mobile_type", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
