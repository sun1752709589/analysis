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

ActiveRecord::Schema.define(version: 20160114110000) do

  create_table "ac_controller_profiles", force: :cascade do |t|
    t.integer  "ac_controller_id",      limit: 4
    t.string   "state",                 limit: 255,   default: "learning"
    t.string   "function",              limit: 255
    t.string   "profile_type",          limit: 255
    t.string   "session_id",            limit: 255
    t.text     "waveforms",             limit: 65535
    t.integer  "testing_step",          limit: 4
    t.datetime "learn_succeeded_at"
    t.datetime "learn_failed_at"
    t.datetime "deprecated_at"
    t.datetime "test_started_at"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.text     "waveforms_hot",         limit: 65535
    t.boolean  "is_magic",                            default: false,      null: false
    t.boolean  "magic_forbidden",                     default: true,       null: false
    t.text     "failed_magic_learning", limit: 65535
  end

  create_table "ac_controllers", force: :cascade do |t|
    t.integer  "device_info_id",     limit: 4
    t.string   "name",               limit: 255
    t.integer  "user_id",            limit: 4
    t.integer  "house_id",           limit: 4
    t.integer  "type_id",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "target_temperature", limit: 24
    t.boolean  "turned_on"
    t.integer  "router_id",          limit: 4
    t.string   "session_id",         limit: 255
    t.text     "ac_learner",         limit: 65535
  end

  add_index "ac_controllers", ["device_info_id"], name: "index_ac_controllers_on_device_info_id", using: :btree
  add_index "ac_controllers", ["house_id"], name: "index_ac_controllers_on_house_id", using: :btree
  add_index "ac_controllers", ["user_id"], name: "index_ac_controllers_on_user_id", using: :btree

  create_table "access_sharings", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "shareable_id",   limit: 4
    t.string   "shareable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "from_key",       limit: 4
  end

  add_index "access_sharings", ["shareable_id", "shareable_type"], name: "index_access_sharings_on_shareable_id_and_shareable_type", using: :btree
  add_index "access_sharings", ["user_id"], name: "index_access_sharings_on_user_id", using: :btree

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "adjustments", force: :cascade do |t|
    t.string   "source_type",     limit: 255
    t.integer  "source_id",       limit: 4
    t.string   "label",           limit: 255
    t.integer  "amount",          limit: 4
    t.integer  "adjustable_id",   limit: 4
    t.string   "adjustable_type", limit: 255
    t.string   "type",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ai_weekly_scenarios", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "scenario_id", limit: 255
    t.integer  "minute",      limit: 4
    t.integer  "wday",        limit: 4
    t.integer  "duration",    limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "weight",      limit: 4
  end

  create_table "air_quality_data", force: :cascade do |t|
    t.integer  "air_quality_sensor_id", limit: 4
    t.float    "air_quality",           limit: 24
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "air_quality_data", ["air_quality_sensor_id", "time"], name: "index_air_quality_data_on_air_quality_sensor_id_and_time", using: :btree
  add_index "air_quality_data", ["air_quality_sensor_id"], name: "index_air_quality_data_on_air_quality_sensor_id", using: :btree
  add_index "air_quality_data", ["id", "time"], name: "index_air_quality_data_on_id_and_time", using: :btree
  add_index "air_quality_data", ["time"], name: "index_air_quality_data_on_time", using: :btree

  create_table "alarm_bulbs", force: :cascade do |t|
    t.integer  "alarm_id",   limit: 4
    t.integer  "bulb_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alarm_bulbs", ["alarm_id"], name: "index_alarm_bulbs_on_alarm_id", using: :btree
  add_index "alarm_bulbs", ["bulb_id", "alarm_id"], name: "index_alarm_bulbs_on_bulb_id_and_alarm_id", using: :btree
  add_index "alarm_bulbs", ["bulb_id"], name: "index_alarm_bulbs_on_bulb_id", using: :btree

  create_table "alarms", force: :cascade do |t|
    t.integer  "user_id",                 limit: 4
    t.integer  "time_in_minute",          limit: 4
    t.integer  "repeat",                  limit: 4
    t.integer  "mode_index",              limit: 4
    t.boolean  "turned_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tag",                     limit: 255
    t.integer  "push_index",              limit: 4
    t.integer  "scenario_id",             limit: 4
    t.integer  "klass",                   limit: 4,   default: 1,     null: false
    t.integer  "relative_time_in_minute", limit: 4
    t.integer  "scenario_id_aux",         limit: 4
    t.boolean  "will_fade",                           default: false, null: false
    t.integer  "fade_time",               limit: 4,   default: 0,     null: false
    t.datetime "alarm_last_sent_at"
  end

  add_index "alarms", ["user_id"], name: "index_alarms_on_user_id", using: :btree

  create_table "apn_apps", force: :cascade do |t|
    t.text     "apn_dev_cert",  limit: 65535
    t.text     "apn_prod_cert", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "apn_device_groupings", force: :cascade do |t|
    t.integer "group_id",  limit: 4
    t.integer "device_id", limit: 4
  end

  add_index "apn_device_groupings", ["device_id"], name: "index_apn_device_groupings_on_device_id", using: :btree
  add_index "apn_device_groupings", ["group_id", "device_id"], name: "index_apn_device_groupings_on_group_id_and_device_id", using: :btree
  add_index "apn_device_groupings", ["group_id"], name: "index_apn_device_groupings_on_group_id", using: :btree

  create_table "apn_devices", force: :cascade do |t|
    t.string   "token",              limit: 255, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_registered_at"
    t.integer  "app_id",             limit: 4
  end

  add_index "apn_devices", ["token"], name: "index_apn_devices_on_token", using: :btree

  create_table "apn_group_notifications", force: :cascade do |t|
    t.integer  "group_id",          limit: 4,     null: false
    t.string   "device_language",   limit: 255
    t.string   "sound",             limit: 255
    t.string   "alert",             limit: 255
    t.integer  "badge",             limit: 4
    t.text     "custom_properties", limit: 65535
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apn_group_notifications", ["group_id"], name: "index_apn_group_notifications_on_group_id", using: :btree

  create_table "apn_groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id",     limit: 4
  end

  create_table "apn_notifications", force: :cascade do |t|
    t.integer  "device_id",         limit: 4,                 null: false
    t.integer  "errors_nb",         limit: 4,     default: 0
    t.string   "device_language",   limit: 255
    t.string   "sound",             limit: 255
    t.string   "alert",             limit: 255
    t.integer  "badge",             limit: 4
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "custom_properties", limit: 65535
  end

  add_index "apn_notifications", ["device_id"], name: "index_apn_notifications_on_device_id", using: :btree

  create_table "apn_pull_notifications", force: :cascade do |t|
    t.integer  "app_id",              limit: 4
    t.string   "title",               limit: 255
    t.string   "content",             limit: 255
    t.string   "link",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "launch_notification"
  end

  create_table "armies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id",    limit: 4
    t.string   "auditable_type",  limit: 255
    t.integer  "associated_id",   limit: 4
    t.string   "associated_type", limit: 255
    t.integer  "user_id",         limit: 4
    t.string   "user_type",       limit: 255
    t.string   "username",        limit: 255
    t.string   "action",          limit: 255
    t.text     "audited_changes", limit: 65535
    t.integer  "version",         limit: 4,     default: 0
    t.string   "comment",         limit: 255
    t.string   "remote_address",  limit: 255
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "bar_codes", force: :cascade do |t|
    t.string   "unumber",       limit: 255
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "bar_codes", ["unumber"], name: "index_bar_codes_on_unumber", unique: true, using: :btree

  create_table "batch_production_device_infos", force: :cascade do |t|
    t.integer  "batch_production_id", limit: 4
    t.integer  "device_info_id",      limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "batch_productions", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.string   "batch_description", limit: 255
    t.string   "state",             limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "device_type",       limit: 255
  end

  create_table "bulb_group_relationships", force: :cascade do |t|
    t.integer  "bulb_id",       limit: 4
    t.integer  "bulb_group_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bulb_group_relationships", ["bulb_group_id"], name: "index_bulb_group_relationships_on_bulb_group_id", using: :btree
  add_index "bulb_group_relationships", ["bulb_id"], name: "index_bulb_group_relationships_on_bulb_id", using: :btree

  create_table "bulb_groups", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.string   "name",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "house_id",       limit: 4
    t.string   "state",          limit: 255
    t.integer  "leader_bulb_id", limit: 4
    t.datetime "deleted_at"
  end

  add_index "bulb_groups", ["house_id"], name: "index_bulb_groups_on_house_id", using: :btree
  add_index "bulb_groups", ["user_id"], name: "index_bulb_groups_on_user_id", using: :btree

  create_table "bulb_modes", force: :cascade do |t|
    t.integer  "index",      limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bulb_modes", ["index"], name: "index_bulb_modes_on_index", using: :btree

  create_table "bulbs", force: :cascade do |t|
    t.integer  "device_info_id",      limit: 4
    t.integer  "user_id",             limit: 4
    t.integer  "router_id",           limit: 4
    t.string   "name",                limit: 255
    t.float    "brightness",          limit: 24
    t.float    "hue",                 limit: 24
    t.boolean  "turned_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "house_id",            limit: 4
    t.integer  "channel",             limit: 4
    t.integer  "wall_switch_id",      limit: 4
    t.integer  "army_id",             limit: 4
    t.integer  "army_rank",           limit: 4
    t.integer  "cmd_sequence",        limit: 4
    t.integer  "alias_bulb_group_id", limit: 4
    t.datetime "script_end_time"
    t.boolean  "bulb_group_leader"
    t.integer  "position",            limit: 4,   default: 9999
    t.boolean  "auto_hue",                        default: false
    t.integer  "pwm",                 limit: 4
  end

  add_index "bulbs", ["device_info_id"], name: "index_bulbs_on_device_info_id", using: :btree
  add_index "bulbs", ["house_id"], name: "index_bulbs_on_house_id", using: :btree
  add_index "bulbs", ["router_id"], name: "index_bulbs_on_router_id", using: :btree
  add_index "bulbs", ["user_id"], name: "index_bulbs_on_user_id", using: :btree
  add_index "bulbs", ["wall_switch_id"], name: "index_bulbs_on_wall_switch_id", using: :btree

  create_table "calibrate_data", force: :cascade do |t|
    t.integer  "data_type",      limit: 4
    t.integer  "device_info_id", limit: 4
    t.integer  "raw_value",      limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "time"
  end

  add_index "calibrate_data", ["created_at"], name: "index_calibrate_data_on_created_at", using: :btree

  create_table "calibrate_meta_data", force: :cascade do |t|
    t.integer  "device_info_id", limit: 4
    t.integer  "router_id",      limit: 4
    t.integer  "status",         limit: 4
    t.integer  "average_value",  limit: 4
    t.text     "json_data",      limit: 65535
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "strategy",       limit: 4,     default: 0, null: false
    t.string   "hint",           limit: 255
    t.integer  "coefficient_a1", limit: 4
    t.integer  "coefficient_a2", limit: 4
    t.integer  "coefficient_c1", limit: 4
    t.integer  "coefficient_c2", limit: 4
    t.float    "k",              limit: 24
    t.float    "c",              limit: 24
  end

  create_table "cookbooks", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "image_url",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "episode",    limit: 255
  end

  create_table "cookbooks_recipes", id: false, force: :cascade do |t|
    t.integer "cookbook_id", limit: 4
    t.integer "recipe_id",   limit: 4
  end

  add_index "cookbooks_recipes", ["cookbook_id"], name: "index_cookbooks_recipes_on_cookbook_id", using: :btree
  add_index "cookbooks_recipes", ["recipe_id"], name: "index_cookbooks_recipes_on_recipe_id", using: :btree

  create_table "coordination_content_items", force: :cascade do |t|
    t.integer "coordination_id",    limit: 4
    t.integer "coordinatable_id",   limit: 4
    t.string  "coordinatable_type", limit: 255
  end

  create_table "coordinations", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.string   "coordination_type", limit: 255
    t.string   "name",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupons", force: :cascade do |t|
    t.integer  "coupon_code_verifier_id", limit: 4
    t.string   "code",                    limit: 255
    t.integer  "user_id",                 limit: 4
    t.datetime "used_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "coupons", ["code"], name: "index_coupon_codes_on_code", unique: true, using: :btree

  create_table "daily_statistical_items", force: :cascade do |t|
    t.integer  "year",       limit: 4
    t.integer  "month",      limit: 4
    t.integer  "day",        limit: 4
    t.integer  "obj_id",     limit: 4
    t.string   "obj_type",   limit: 255
    t.string   "key",        limit: 255
    t.integer  "value",      limit: 4,   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "daily_statistical_items", ["year", "month", "day"], name: "index_daily_statistical_items_on_year_and_month_and_day", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,          default: 0
    t.integer  "attempts",   limit: 4,          default: 0
    t.text     "handler",    limit: 4294967295
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "derivative_daily_statistical_items", force: :cascade do |t|
    t.integer  "year",       limit: 4
    t.integer  "month",      limit: 4
    t.integer  "day",        limit: 4
    t.string   "key",        limit: 255
    t.float    "value",      limit: 53
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "derivative_daily_statistical_items", ["year", "month", "day"], name: "index_derivative_daily_statistical_items_on_ymd", using: :btree

  create_table "device_connectivities", force: :cascade do |t|
    t.integer  "device_info_id",                limit: 4
    t.integer  "connectivity",                  limit: 4, default: 0
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.datetime "last_online_at"
    t.datetime "last_offline_at"
    t.integer  "accumulated_usage_time",        limit: 8, default: 0, null: false
    t.integer  "been_online",                   limit: 4, default: 0
    t.integer  "accumulated_usage_time_offset", limit: 8, default: 0
  end

  add_index "device_connectivities", ["device_info_id"], name: "index_device_connectivities_on_device_info_id", unique: true, using: :btree

  create_table "device_infos", force: :cascade do |t|
    t.string   "device_type",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "device_ip",                  limit: 8
    t.datetime "notification_time"
    t.string   "private_key",                limit: 255
    t.string   "version_info",               limit: 255
    t.integer  "gadget_id",                  limit: 4
    t.integer  "daily_statistical_progress", limit: 4,   default: 0, null: false
    t.integer  "force_firmware_id",          limit: 4
  end

  create_table "device_match_instructions", force: :cascade do |t|
    t.string   "device_type",       limit: 255
    t.string   "vpid",              limit: 255
    t.string   "noise_op",          limit: 255
    t.string   "silence_op",        limit: 255
    t.string   "device_type_words", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "monitor_op",        limit: 255
  end

  create_table "device_matches", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "state",      limit: 255
    t.string   "score",      limit: 255
    t.integer  "count",      limit: 4
    t.string   "code",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hotel_id",   limit: 4
  end

  create_table "device_neighbour_lists", force: :cascade do |t|
    t.string   "gateway_addr",       limit: 255
    t.string   "device_addr",        limit: 255
    t.string   "remote_device_addr", limit: 255
    t.string   "status",             limit: 255
    t.string   "remote_quality",     limit: 255
    t.string   "local_quality",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "device_route_lists", force: :cascade do |t|
    t.string   "gateway_addr",  limit: 255
    t.string   "device_addr",   limit: 255
    t.string   "remote_addr",   limit: 255
    t.string   "trunking_addr", limit: 255
    t.string   "cost",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "device_usages", force: :cascade do |t|
    t.integer  "device_info_id",              limit: 4
    t.datetime "turned_on_at"
    t.datetime "turned_off_at"
    t.integer  "channel_accumulated_minutes", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "channel",                     limit: 4
  end

  create_table "door_accesses", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "device_info_id", limit: 4
    t.integer  "user_id",        limit: 4
    t.integer  "house_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",       limit: 4
  end

  create_table "door_sensor_statistics", force: :cascade do |t|
    t.datetime "date"
    t.integer  "added_ds_count",             limit: 4
    t.integer  "added_ds_user_count",        limit: 4
    t.float    "rename_rate",                limit: 24
    t.float    "set_scenario_rate",          limit: 24
    t.float    "set_secure_phone_rate",      limit: 24
    t.float    "ds_used_rate",               limit: 24
    t.float    "ds_user_used_rate",          limit: 24
    t.float    "alert_enabled_rate",         limit: 24
    t.float    "scenario_applied_rate",      limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "enable_three_minutes_alert", limit: 4,  default: 0
    t.integer  "always_secure_users",        limit: 4,  default: 0
    t.integer  "push_secure_users",          limit: 4,  default: 0
    t.integer  "sms_secure_users",           limit: 4,  default: 0
  end

  create_table "door_sensors", force: :cascade do |t|
    t.integer  "device_info_id",        limit: 4
    t.integer  "user_id",               limit: 4
    t.integer  "router_id",             limit: 4
    t.string   "name",                  limit: 255
    t.boolean  "is_open"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "house_id",              limit: 4
    t.integer  "alert_mode",            limit: 4
    t.integer  "alert_status",          limit: 4
    t.integer  "scenario_id1",          limit: 4
    t.integer  "scenario_id2",          limit: 4
    t.datetime "last_guarded_time"
    t.datetime "last_trigger_time"
    t.boolean  "in_defence_system",                 default: true
    t.datetime "synced_time"
    t.integer  "position",              limit: 4,   default: 9999
    t.boolean  "is_open_history"
    t.boolean  "long_time_open_alert",              default: false
    t.datetime "last_open_time"
    t.datetime "last_alert_time"
    t.datetime "first_rename_at"
    t.datetime "first_set_scenario_at"
  end

  add_index "door_sensors", ["device_info_id"], name: "index_door_sensors_on_device_info_id", using: :btree
  add_index "door_sensors", ["house_id"], name: "index_door_sensors_on_house_id", using: :btree
  add_index "door_sensors", ["router_id"], name: "index_door_sensors_on_router_id", using: :btree
  add_index "door_sensors", ["user_id"], name: "index_door_sensors_on_user_id", using: :btree

  create_table "download_tasks", force: :cascade do |t|
    t.integer  "status",       limit: 4
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "try_abort_at"
    t.integer  "router_addr",  limit: 4
    t.integer  "device_addr",  limit: 4
    t.string   "url",          limit: 255
    t.text     "payload",      limit: 65535
    t.string   "type",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "redundant",    limit: 65535
  end

  create_table "eco_towers", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.integer  "device_info_id",     limit: 4
    t.integer  "user_id",            limit: 4
    t.integer  "house_id",           limit: 4
    t.integer  "router_id",          limit: 4
    t.float    "target_temperature", limit: 24
    t.boolean  "turned_on"
    t.string   "session_id",         limit: 255
    t.string   "a_name",             limit: 255
    t.string   "t_name",             limit: 255
    t.string   "q_name",             limit: 255
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "type",               limit: 255
    t.integer  "mode",               limit: 4
    t.integer  "timing_mode",        limit: 4
    t.boolean  "plasma_turned_on"
    t.integer  "position",           limit: 4,   default: 9999
    t.integer  "target_fan_speed",   limit: 4,   default: 0
    t.integer  "target_mode",        limit: 4,   default: 0
  end

  create_table "event_statistics", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "detail",     limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_agent", limit: 255
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "user_id",    limit: 255
    t.string   "message",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "festivals", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "phone",       limit: 255
    t.string   "random_num",  limit: 255
    t.string   "promo_code",  limit: 255
    t.string   "promo_price", limit: 255
    t.string   "distance",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "used_at"
    t.integer  "order_id",    limit: 4
    t.string   "src_user_id", limit: 255
    t.string   "dst_user_id", limit: 255
  end

  add_index "festivals", ["order_id"], name: "index_festivals_on_order_id", using: :btree

  create_table "firmwares", force: :cascade do |t|
    t.string   "version",            limit: 255,                   null: false
    t.text     "changelog",          limit: 65535
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.string   "device_type",        limit: 255,                   null: false
    t.boolean  "pushed",                           default: false, null: false
    t.datetime "compiled_at"
    t.integer  "beta_pushed_status", limit: 4,     default: 0
    t.boolean  "rc_mark",                          default: false
    t.integer  "user_id",            limit: 4
  end

  create_table "fix_router_devices", force: :cascade do |t|
    t.integer  "device_id",     limit: 4
    t.string   "device_type",   limit: 255
    t.integer  "fix_router_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gadget_packages", force: :cascade do |t|
    t.integer  "order_item_id",       limit: 4
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.string   "state",               limit: 255, default: "manufectured"
    t.datetime "confirmed_at"
    t.datetime "allocated_at"
    t.datetime "recycled_at"
    t.string   "eigenvalue",          limit: 255
    t.datetime "reported_missing_at"
    t.datetime "quality_checked_at"
  end

  create_table "gadgets", force: :cascade do |t|
    t.integer  "gadget_package_id",   limit: 4
    t.string   "state",               limit: 255, default: "manufectured"
    t.datetime "confirmed_at"
    t.datetime "allocated_at"
    t.datetime "recycled_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_item_id",       limit: 4
    t.datetime "reported_missing_at"
    t.string   "quality",             limit: 255
    t.string   "style",               limit: 255
    t.integer  "pid",                 limit: 4
    t.integer  "vid",                 limit: 4
    t.datetime "quality_checked_at"
    t.integer  "test_router_ip",      limit: 4
    t.integer  "test_step",           limit: 4,   default: 0
  end

  create_table "generic_module_data", force: :cascade do |t|
    t.integer "generic_module_id", limit: 4
    t.integer "number",            limit: 4,             null: false
    t.integer "content",           limit: 4, default: 0, null: false
  end

  create_table "generic_module_modes", force: :cascade do |t|
    t.integer "generic_module_id", limit: 4
    t.integer "number",            limit: 4,             null: false
    t.integer "content",           limit: 4, default: 0, null: false
  end

  create_table "generic_module_timestamped_data", force: :cascade do |t|
    t.integer  "generic_module_id", limit: 4
    t.integer  "index",             limit: 4
    t.integer  "value",             limit: 4
    t.datetime "time"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "generic_modules", force: :cascade do |t|
    t.integer  "device_info_id", limit: 4
    t.integer  "user_id",        limit: 4
    t.integer  "router_id",      limit: 4
    t.integer  "house_id",       limit: 4
    t.string   "name",           limit: 255
    t.integer  "bools_content",  limit: 8,   default: 0,    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vid",            limit: 4,   default: 0
    t.integer  "pid",            limit: 4,   default: 0
    t.integer  "position",       limit: 4,   default: 9999
    t.string   "type",           limit: 255
    t.boolean  "reverse"
    t.integer  "conf_int",       limit: 4
  end

  create_table "header_images", force: :cascade do |t|
    t.string   "image_url",           limit: 255
    t.string   "title",               limit: 255
    t.string   "desc",                limit: 255
    t.string   "content_url",         limit: 255
    t.string   "type",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "android_min_version", limit: 255
    t.string   "ios_min_version",     limit: 255
  end

  create_table "hl_owners", force: :cascade do |t|
    t.integer  "wall_switch_id",           limit: 4
    t.integer  "channel",                  limit: 4
    t.string   "state",                    limit: 255, default: "assessing"
    t.integer  "points",                   limit: 4,   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "received_sequence_number", limit: 4,   default: 0
    t.integer  "sent_sequence_number",     limit: 4,   default: 0
  end

  add_index "hl_owners", ["wall_switch_id", "channel"], name: "index_hl_owners_on_wall_switch_id_and_channel", unique: true, using: :btree

  create_table "hl_targets", force: :cascade do |t|
    t.integer  "hl_owner_id", limit: 4
    t.integer  "device_ip",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hl_targets", ["hl_owner_id", "device_ip"], name: "index_hl_targets_on_hl_owner_id_and_device_ip", unique: true, using: :btree

  create_table "hotel_room_ctrls", force: :cascade do |t|
    t.integer  "hotel_id",    limit: 4
    t.integer  "house_id",    limit: 4
    t.string   "code",        limit: 255
    t.string   "manage_url",  limit: 255
    t.string   "phone",       limit: 255
    t.datetime "verified_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hotel_room_type_item_wall_switches", force: :cascade do |t|
    t.integer  "hotel_room_type_id", limit: 4
    t.string   "name",               limit: 255
    t.string   "device_type",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hotel_room_type_items", force: :cascade do |t|
    t.integer  "hotel_room_type_id",                  limit: 4
    t.string   "device_type",                         limit: 255
    t.string   "device_name",                         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hotel_room_type_item_wall_switch_id", limit: 4
    t.integer  "channel",                             limit: 4
  end

  create_table "hotel_room_types", force: :cascade do |t|
    t.integer  "hotel_id",   limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hotels", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.integer  "user_id",          limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone",            limit: 255
    t.string   "logo",             limit: 255
    t.string   "manager",          limit: 255
    t.string   "address",          limit: 255
    t.string   "theme",            limit: 255
    t.string   "modules",          limit: 255
    t.boolean  "show_banner_logo"
  end

  create_table "houses", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.string   "name",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hotel_id",           limit: 4
    t.text     "description",        limit: 65535
    t.string   "partner_id",         limit: 255
    t.integer  "hotel_room_type_id", limit: 4
  end

  add_index "houses", ["user_id"], name: "index_houses_on_user_id", using: :btree

  create_table "humidity_data", force: :cascade do |t|
    t.integer  "th_sensor_id",           limit: 4
    t.float    "humidity_in_percentage", limit: 24
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "humidity_data", ["th_sensor_id", "time"], name: "index_humidity_data_on_th_sensor_id_and_time", using: :btree
  add_index "humidity_data", ["th_sensor_id"], name: "index_humidity_data_on_th_sensor_id", using: :btree
  add_index "humidity_data", ["time"], name: "index_humidity_data_on_time", using: :btree

  create_table "huohe_locks", force: :cascade do |t|
    t.string   "ip",         limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "house_id",   limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hyperlink_targets", force: :cascade do |t|
    t.integer  "wall_switch_id", limit: 4
    t.integer  "channel",        limit: 4
    t.integer  "target_ip",      limit: 4
    t.integer  "event",          limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "infrared_sensors", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.integer  "device_info_id",         limit: 4
    t.integer  "user_id",                limit: 4
    t.integer  "router_id",              limit: 4
    t.integer  "house_id",               limit: 4
    t.datetime "synced_time"
    t.boolean  "c0"
    t.datetime "c0_changed_at"
    t.boolean  "c1"
    t.datetime "c1_changed_at"
    t.boolean  "c2"
    t.datetime "c2_changed_at"
    t.boolean  "c3"
    t.datetime "c3_changed_at"
    t.boolean  "c4"
    t.datetime "c4_changed_at"
    t.boolean  "c5"
    t.datetime "c5_changed_at"
    t.boolean  "c6"
    t.datetime "c6_changed_at"
    t.boolean  "c7"
    t.datetime "c7_changed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",               limit: 4,   default: 9999
    t.string   "cfg_channels",           limit: 255
    t.string   "cfg_parameters",         limit: 255
    t.string   "cfg_channels_new",       limit: 255
    t.string   "cfg_parameters_new",     limit: 255
    t.boolean  "cfg_channel_updating"
    t.boolean  "cfg_parameter_updating"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "order_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "links", force: :cascade do |t|
    t.string  "sender_id",                    limit: 255
    t.string  "receiver_id",                  limit: 255
    t.integer "content_id",                   limit: 4
    t.boolean "sender_connect",                           default: false
    t.boolean "receiver_connect",                         default: false
    t.integer "verbose_sender_device_info",   limit: 4
    t.integer "verbose_receiver_device_info", limit: 4
  end

  add_index "links", ["verbose_receiver_device_info"], name: "index_links_on_verbose_receiver_device_info", using: :btree
  add_index "links", ["verbose_sender_device_info"], name: "index_links_on_verbose_sender_device_info", using: :btree

  create_table "locations", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "device_uuid", limit: 255
    t.float    "lat",         limit: 24
    t.float    "lng",         limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "info",        limit: 255
  end

  create_table "match_device_name_items", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.integer  "channel",              limit: 4
    t.integer  "match_device_name_id", limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "match_device_names", force: :cascade do |t|
    t.integer  "device_match_id", limit: 4
    t.string   "name",            limit: 255
    t.integer  "room_name",       limit: 4
    t.integer  "device_type",     limit: 4
    t.integer  "zone_name",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vpid",            limit: 255
  end

  create_table "match_tag_kinds", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "symbol",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "match_tags", force: :cascade do |t|
    t.integer  "device_match_id",   limit: 4
    t.integer  "match_tag_kind_id", limit: 4
    t.string   "name",              limit: 255
    t.integer  "house_id",          limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matched_devices", force: :cascade do |t|
    t.integer  "device_match_id",      limit: 4
    t.integer  "match_device_name_id", limit: 4
    t.integer  "device_ip",            limit: 8
    t.integer  "matched_at",           limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "house_id",             limit: 4
  end

  create_table "mid_festival_users", force: :cascade do |t|
    t.string   "user_id",    limit: 255
    t.float    "lat",        limit: 24
    t.float    "lng",        limit: 24
    t.string   "nick_name",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nespresso_orders", force: :cascade do |t|
    t.string   "trade_id",     limit: 255
    t.integer  "nespresso_id", limit: 4
    t.string   "state",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_items", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.text     "body",                limit: 65535
    t.boolean  "pushed_to_weibo",                   default: false,                      null: false
    t.datetime "pushed_to_weibo_at"
    t.boolean  "pushed_to_weixin",                  default: false,                      null: false
    t.datetime "pushed_to_weixin_at"
    t.boolean  "pushed_to_bbs",                     default: false,                      null: false
    t.datetime "pushed_to_bbs_at"
    t.boolean  "pushed_to_apps",                    default: false,                      null: false
    t.datetime "pushed_to_apps_at"
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.string   "image_file_name",     limit: 255
    t.string   "image_content_type",  limit: 255
    t.integer  "image_file_size",     limit: 4
    t.datetime "image_updated_at"
    t.string   "read_more_link",      limit: 255,   default: "http://huantengsmart.com", null: false
  end

  create_table "news_subitems", force: :cascade do |t|
    t.integer  "news_item_id",       limit: 4
    t.string   "title",              limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "sort_order",         limit: 4,   default: 0, null: false
  end

  create_table "node_groups", force: :cascade do |t|
    t.integer  "device_id",     limit: 4
    t.string   "device_type",   limit: 255
    t.integer  "channel",       limit: 4
    t.boolean  "build_success",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version",       limit: 4,   default: 0
  end

  create_table "node_statuses", force: :cascade do |t|
    t.integer  "child_count",   limit: 4
    t.boolean  "success",                   default: false
    t.integer  "node_group_id", limit: 4
    t.integer  "version",       limit: 4
    t.string   "uuid",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "father_id",     limit: 4
  end

  add_index "node_statuses", ["father_id"], name: "index_node_statuses_on_father_id", using: :btree

  create_table "nodes", force: :cascade do |t|
    t.boolean "deleted"
    t.integer "scenario_id",   limit: 4
    t.integer "index",         limit: 4
    t.integer "node_group_id", limit: 4
  end

  create_table "one2014applies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "phone",      limit: 255
    t.string   "company",    limit: 255
    t.string   "job",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "newhouse"
  end

  create_table "operation_log_devices", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "device_type", limit: 255
    t.integer  "device_id",   limit: 4
    t.string   "message",     limit: 255
    t.integer  "timestamp",   limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content",     limit: 65535
  end

  create_table "operation_log_users", force: :cascade do |t|
    t.integer "user_id",   limit: 4
    t.string  "op_type",   limit: 255
    t.string  "command",   limit: 255
    t.string  "params",    limit: 255
    t.integer "origin",    limit: 4
    t.integer "timestamp", limit: 8
  end

  create_table "opro_auth_grants", force: :cascade do |t|
    t.string   "code",                    limit: 255
    t.string   "access_token",            limit: 255
    t.string   "refresh_token",           limit: 255
    t.text     "permissions",             limit: 65535
    t.datetime "access_token_expires_at"
    t.integer  "user_id",                 limit: 4
    t.integer  "application_id",          limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_agent",              limit: 255
    t.string   "device_name",             limit: 255
    t.string   "device_uuid",             limit: 255
  end

  add_index "opro_auth_grants", ["access_token"], name: "index_opro_auth_grants_on_access_token", unique: true, using: :btree
  add_index "opro_auth_grants", ["code"], name: "index_opro_auth_grants_on_code", unique: true, using: :btree
  add_index "opro_auth_grants", ["refresh_token"], name: "index_opro_auth_grants_on_refresh_token", unique: true, using: :btree

  create_table "opro_client_apps", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "app_id",      limit: 255
    t.string   "app_secret",  limit: 255
    t.text     "permissions", limit: 65535
    t.integer  "user_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description", limit: 65535
  end

  add_index "opro_client_apps", ["app_id", "app_secret"], name: "index_opro_client_apps_on_app_id_and_app_secret", unique: true, using: :btree
  add_index "opro_client_apps", ["app_id"], name: "index_opro_client_apps_on_app_id", unique: true, using: :btree

  create_table "order_batches", force: :cascade do |t|
    t.integer  "number",     limit: 4
    t.date     "deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id", limit: 4
  end

  create_table "order_items", force: :cascade do |t|
    t.string   "unumber",                   limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "product_id",                limit: 4
    t.integer  "amount",                    limit: 4,   default: 1, null: false
    t.integer  "calculated_price_in_cents", limit: 4
    t.string   "order_item_father_type",    limit: 255
    t.integer  "order_item_father_id",      limit: 4
    t.string   "comment",                   limit: 255
    t.integer  "product_sku_id",            limit: 4
  end

  create_table "ordered_devices", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "device_type", limit: 255
    t.string   "vpid",        limit: 255
    t.integer  "device_ip",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",                   limit: 4
    t.integer  "shipping_info_id",          limit: 4
    t.string   "order_number",              limit: 255
    t.string   "shipping_number",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "batch",                     limit: 4
    t.text     "raw_request_string",        limit: 65535
    t.datetime "raw_request_time"
    t.string   "heard_from",                limit: 255
    t.string   "short_sfnum",               limit: 255
    t.datetime "completed_at"
    t.datetime "payed_at"
    t.datetime "allocated_at"
    t.datetime "shipped_at"
    t.datetime "closed_at"
    t.datetime "recalled_at"
    t.string   "state",                     limit: 255,   default: "incomplete"
    t.integer  "calculated_price_in_cents", limit: 4
    t.datetime "price_frozen_at"
    t.boolean  "require_receipt",                         default: false,        null: false
    t.string   "require_receipt_title",     limit: 255
    t.string   "entered_coupon_code",       limit: 255
    t.datetime "refunded_at"
    t.boolean  "old_alipay"
    t.string   "manual_to_whom",            limit: 255
    t.string   "manual_why",                limit: 255
    t.string   "manual_money_to_whom",      limit: 255
    t.string   "manual_money_where",        limit: 255
    t.string   "origin",                    limit: 255
    t.integer  "order_batch_id",            limit: 4
    t.boolean  "sales_permit"
    t.integer  "parent_order_id",           limit: 4
    t.boolean  "is_parent"
  end

  add_index "orders", ["order_number"], name: "index_orders_on_order_number", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "outside_users", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "app_id",     limit: 255
    t.string   "out_id",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_views", force: :cascade do |t|
    t.string   "visitor",         limit: 255
    t.string   "method",          limit: 255
    t.text     "fullpath",        limit: 65535
    t.string   "format",          limit: 255
    t.boolean  "user_signed_in"
    t.string   "remote_ip",       limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "params",          limit: 65535
    t.string   "user_agent",      limit: 255
    t.string   "action_name",     limit: 255
    t.integer  "stuff_id",        limit: 4
    t.integer  "date_int",        limit: 4
    t.string   "controller_name", limit: 255
    t.string   "stuff_type",      limit: 255
    t.string   "special",         limit: 255
    t.integer  "origin",          limit: 4
    t.string   "device_name",     limit: 255
  end

  add_index "page_views", ["created_at", "visitor", "format"], name: "index_page_views_on_created_at_and_visitor_and_format", using: :btree
  add_index "page_views", ["created_at", "visitor"], name: "index_page_views_on_created_at_and_visitor", using: :btree
  add_index "page_views", ["created_at"], name: "index_page_views_on_created_at", using: :btree
  add_index "page_views", ["date_int"], name: "index_page_views_on_date_int", using: :btree
  add_index "page_views", ["origin"], name: "index_page_views_on_origin", using: :btree
  add_index "page_views", ["stuff_id"], name: "index_page_views_on_stuff_id", using: :btree
  add_index "page_views", ["user_signed_in", "created_at", "format"], name: "index_page_views_on_user_signed_in_and_created_at_and_format", using: :btree
  add_index "page_views", ["user_signed_in", "created_at", "visitor"], name: "index_page_views_on_user_signed_in_and_created_at_and_visitor", using: :btree
  add_index "page_views", ["user_signed_in", "created_at"], name: "index_page_views_on_user_signed_in_and_created_at", using: :btree
  add_index "page_views", ["visitor"], name: "index_page_views_on_visitor", using: :btree

  create_table "partners", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "app_id",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pcdi_daily_values", force: :cascade do |t|
    t.integer  "year",       limit: 4
    t.integer  "month",      limit: 4
    t.integer  "day",        limit: 4
    t.float    "open",       limit: 24
    t.float    "high",       limit: 24
    t.float    "low",        limit: 24
    t.float    "close",      limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.float    "sales",      limit: 24
  end

  create_table "pcdi_statistical_items", force: :cascade do |t|
    t.integer  "rho",                  limit: 4
    t.integer  "epsilon",              limit: 4
    t.integer  "N",                    limit: 4
    t.text     "little_lambdas",       limit: 65535
    t.text     "big_lambdas",          limit: 65535
    t.text     "xis",                  limit: 65535
    t.integer  "M",                    limit: 4
    t.text     "upsilons",             limit: 65535
    t.text     "alphas",               limit: 65535
    t.text     "betas",                limit: 65535
    t.float    "bar_alpha",            limit: 24
    t.float    "bar_beta",             limit: 24
    t.float    "Delta_P",              limit: 24
    t.float    "Delta_U",              limit: 24
    t.float    "result",               limit: 24
    t.datetime "result_calculated_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.text     "effective_user_ids",   limit: 65535
    t.float    "numerator_phase1",     limit: 24
    t.float    "numerator_phase2",     limit: 24
    t.float    "numerator_phase3",     limit: 24
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "describe",   limit: 255
    t.string   "code",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions_user_groups", force: :cascade do |t|
    t.integer "user_group_id", limit: 4
    t.integer "permission_id", limit: 4
  end

  add_index "permissions_user_groups", ["permission_id"], name: "index_permissions_user_groups_on_permission_id", using: :btree
  add_index "permissions_user_groups", ["user_group_id"], name: "index_permissions_user_groups_on_user_group_id", using: :btree

  create_table "pixel_app_wall_switches", force: :cascade do |t|
    t.integer  "wall_switch_id", limit: 4
    t.integer  "pixel_app_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "property",       limit: 255
  end

  create_table "pixel_apps", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "description",     limit: 255
    t.string   "url",             limit: 255
    t.integer  "frequency",       limit: 4
    t.string   "parameters",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id",          limit: 4
    t.integer  "command_version", limit: 4,   default: 1
    t.integer  "app_version",     limit: 4,   default: 1
  end

  create_table "pre_orderings", force: :cascade do |t|
    t.string   "phone",       limit: 255
    t.string   "device_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "people_name", limit: 255
  end

  create_table "product_attribute_values", force: :cascade do |t|
    t.integer  "product_id",           limit: 4
    t.integer  "product_attribute_id", limit: 4
    t.integer  "symbol",               limit: 4
    t.string   "value",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url",            limit: 255
  end

  add_index "product_attribute_values", ["product_id", "product_attribute_id"], name: "idx_on_product_and_attribute", using: :btree

  create_table "product_attributes", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_attributes", ["product_id"], name: "index_product_attributes_on_product_id", using: :btree

  create_table "product_skus", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "attr_val_1", limit: 4
    t.integer  "attr_val_2", limit: 4
    t.integer  "attr_val_3", limit: 4
    t.integer  "attr_val_4", limit: 4
    t.integer  "attr_val_5", limit: 4
    t.integer  "price",      limit: 4
    t.integer  "stock",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_skus", ["product_id"], name: "index_product_skus_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.integer  "base_price_in_cents", limit: 4,     default: 0,     null: false
    t.boolean  "on_shelf"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "type",                limit: 255
    t.boolean  "buyable",                           default: false, null: false
    t.text     "description",         limit: 65535
    t.integer  "supplier_id",         limit: 4,     default: 1,     null: false
  end

  create_table "project_distribute_devices", force: :cascade do |t|
    t.string   "dist_type",  limit: 255
    t.text     "dist_num",   limit: 65535
    t.string   "remark",     limit: 255
    t.integer  "project_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "project_items", force: :cascade do |t|
    t.integer "project_id",       limit: 4
    t.string  "symbol",           limit: 255
    t.integer "projectable_id",   limit: 4
    t.string  "projectable_type", limit: 255
  end

  create_table "project_logs", force: :cascade do |t|
    t.string  "process",       limit: 255
    t.string  "message",       limit: 255
    t.integer "loggable_id",   limit: 4
    t.string  "loggable_type", limit: 255
  end

  create_table "projects", force: :cascade do |t|
    t.string  "name",    limit: 255
    t.integer "user_id", limit: 4
  end

  create_table "promotion_actions", force: :cascade do |t|
    t.integer  "promotion_id",              limit: 4
    t.string   "type",                      limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "adjustable_type",           limit: 255
    t.integer  "adjustable_quantity_limit", limit: 4
    t.integer  "adjustable_product_id",     limit: 4
    t.string   "operator",                  limit: 255
    t.integer  "amount",                    limit: 4
    t.string   "prey",                      limit: 255
  end

  create_table "promotion_rules", force: :cascade do |t|
    t.integer  "promotion_id", limit: 4
    t.string   "type",         limit: 255
    t.string   "operator",     limit: 255
    t.integer  "threshold",    limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "prey",         limit: 65535
  end

  create_table "promotions", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "starts_at"
    t.datetime "expires_at"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "timeless",                  default: false, null: false
    t.text     "description", limit: 65535
  end

  create_table "push_updates", force: :cascade do |t|
    t.integer  "pushable_id",         limit: 4
    t.string   "pushable_type",       limit: 255
    t.integer  "try_counts",          limit: 4
    t.integer  "last_settings_index", limit: 4
    t.datetime "last_push_timestamp"
    t.boolean  "need_push"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",                limit: 255
    t.integer  "channel",             limit: 4
  end

  add_index "push_updates", ["pushable_id", "pushable_type"], name: "index_push_updates_on_pushable_id_and_pushable_type", using: :btree

  create_table "qiniu_files", force: :cascade do |t|
    t.string   "url",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "suffix",         limit: 255
    t.string   "tag",            limit: 255
    t.integer  "upload_user_id", limit: 4
    t.string   "file_hash",      limit: 255
    t.string   "key",            limit: 255
  end

  create_table "qr_codes", force: :cascade do |t|
    t.integer  "code_type",          limit: 4
    t.integer  "device_info_id",     limit: 4
    t.integer  "used_times",         limit: 4
    t.datetime "last_usage"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "code",               limit: 255
    t.integer  "last_usage_user_id", limit: 4
    t.integer  "user_id",            limit: 4
  end

  create_table "quality_check_routers", force: :cascade do |t|
    t.integer  "device_info_id", limit: 4
    t.integer  "router_ip",      limit: 8
    t.string   "description",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quality_check_routers", ["router_ip"], name: "index_quality_check_routers_on_router_ip", using: :btree

  create_table "recipe_data_migrations", force: :cascade do |t|
    t.integer  "user_id",              limit: 4
    t.boolean  "wake_up_migrated",               default: false
    t.boolean  "gps_home_migrated",              default: false
    t.boolean  "sleep_alarm_mirgated",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_snapshots", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "recipe_id",  limit: 4
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_steps", force: :cascade do |t|
    t.integer  "recipe_id",  limit: 4
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_num",  limit: 4
  end

  add_index "recipe_steps", ["recipe_id"], name: "index_recipe_steps_on_recipe_id", using: :btree

  create_table "recipes", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "desc",       limit: 255
    t.text     "story",      limit: 65535
    t.string   "image_url",  limit: 255
    t.string   "icon_url",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type2",      limit: 255
    t.boolean  "executable",               default: false
  end

  create_table "recipes_spices", id: false, force: :cascade do |t|
    t.integer "recipe_id", limit: 4
    t.integer "spice_id",  limit: 4
  end

  add_index "recipes_spices", ["recipe_id"], name: "index_recipes_spices_on_recipe_id", using: :btree
  add_index "recipes_spices", ["spice_id"], name: "index_recipes_spices_on_spice_id", using: :btree

  create_table "reimbursements", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,                          null: false
    t.string   "state",      limit: 255,   default: "reported", null: false
    t.integer  "cents",      limit: 4,     default: 0,          null: false
    t.text     "reason",     limit: 65535,                      null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "routers", force: :cascade do |t|
    t.integer  "device_info_id",   limit: 4
    t.integer  "user_id",          limit: 4
    t.string   "name",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "house_id",         limit: 4
    t.boolean  "wifi_state"
    t.boolean  "wifi_logon_ok"
    t.boolean  "wifi_controlable"
    t.string   "wifi_vstring",     limit: 255
    t.string   "wifi_username",    limit: 255
    t.string   "wifi_password",    limit: 255
    t.string   "wifi_router_ip",   limit: 255
    t.integer  "position",         limit: 4,   default: 9999
  end

  add_index "routers", ["device_info_id"], name: "index_routers_on_device_info_id", using: :btree
  add_index "routers", ["house_id"], name: "index_routers_on_house_id", using: :btree
  add_index "routers", ["user_id"], name: "index_routers_on_user_id", using: :btree

  create_table "rpush_apps", force: :cascade do |t|
    t.string   "name",                    limit: 255,               null: false
    t.string   "environment",             limit: 255
    t.text     "certificate",             limit: 65535
    t.string   "password",                limit: 255
    t.integer  "connections",             limit: 4,     default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                    limit: 255,               null: false
    t.string   "auth_key",                limit: 255
    t.string   "client_id",               limit: 255
    t.string   "client_secret",           limit: 255
    t.string   "access_token",            limit: 255
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id",       limit: 4
  end

  add_index "rpush_feedback", ["device_token"], name: "index_rpush_feedback_on_device_token", using: :btree

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer  "badge",             limit: 4
    t.string   "device_token",      limit: 64
    t.string   "sound",             limit: 255,      default: "default"
    t.string   "alert",             limit: 255
    t.text     "data",              limit: 65535
    t.integer  "expiry",            limit: 4,        default: 86400
    t.boolean  "delivered",                          default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                             default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code",        limit: 4
    t.text     "error_description", limit: 65535
    t.datetime "deliver_after"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alert_is_json",                      default: false
    t.string   "type",              limit: 255,                          null: false
    t.string   "collapse_key",      limit: 255
    t.boolean  "delay_while_idle",                   default: false,     null: false
    t.text     "registration_ids",  limit: 16777215
    t.integer  "app_id",            limit: 4,                            null: false
    t.integer  "retries",           limit: 4,        default: 0
    t.string   "uri",               limit: 255
    t.datetime "fail_after"
    t.boolean  "processing",                         default: false,     null: false
    t.integer  "priority",          limit: 4
    t.text     "url_args",          limit: 65535
    t.string   "category",          limit: 255
  end

  add_index "rpush_notifications", ["app_id", "delivered", "failed", "deliver_after"], name: "index_rapns_notifications_multi", using: :btree
  add_index "rpush_notifications", ["delivered", "failed"], name: "index_rpush_notifications_multi", using: :btree

  create_table "rs_evaluations", force: :cascade do |t|
    t.string   "reputation_name", limit: 255
    t.integer  "source_id",       limit: 4
    t.string   "source_type",     limit: 255
    t.integer  "target_id",       limit: 4
    t.string   "target_type",     limit: 255
    t.float    "value",           limit: 24,  default: 0.0
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "rs_evaluations", ["reputation_name", "source_id", "source_type", "target_id", "target_type"], name: "index_rs_evaluations_on_reputation_name_and_source_and_target", unique: true, using: :btree
  add_index "rs_evaluations", ["reputation_name"], name: "index_rs_evaluations_on_reputation_name", using: :btree
  add_index "rs_evaluations", ["source_id", "source_type"], name: "index_rs_evaluations_on_source_id_and_source_type", using: :btree
  add_index "rs_evaluations", ["target_id", "target_type"], name: "index_rs_evaluations_on_target_id_and_target_type", using: :btree

  create_table "rs_reputation_messages", force: :cascade do |t|
    t.integer  "sender_id",   limit: 4
    t.string   "sender_type", limit: 255
    t.integer  "receiver_id", limit: 4
    t.float    "weight",      limit: 24,  default: 1.0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "rs_reputation_messages", ["receiver_id", "sender_id", "sender_type"], name: "index_rs_reputation_messages_on_receiver_id_and_sender", unique: true, using: :btree
  add_index "rs_reputation_messages", ["receiver_id"], name: "index_rs_reputation_messages_on_receiver_id", using: :btree
  add_index "rs_reputation_messages", ["sender_id", "sender_type"], name: "index_rs_reputation_messages_on_sender_id_and_sender_type", using: :btree

  create_table "rs_reputations", force: :cascade do |t|
    t.string   "reputation_name", limit: 255
    t.float    "value",           limit: 24,  default: 0.0
    t.string   "aggregated_by",   limit: 255
    t.integer  "target_id",       limit: 4
    t.string   "target_type",     limit: 255
    t.boolean  "active",                      default: true
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "rs_reputations", ["reputation_name", "target_id", "target_type"], name: "index_rs_reputations_on_reputation_name_and_target", unique: true, using: :btree
  add_index "rs_reputations", ["reputation_name"], name: "index_rs_reputations_on_reputation_name", using: :btree
  add_index "rs_reputations", ["target_id", "target_type"], name: "index_rs_reputations_on_target_id_and_target_type", using: :btree

  create_table "scenario_content_items", force: :cascade do |t|
    t.integer  "scenario_id",        limit: 4
    t.integer  "bulb_id",            limit: 4
    t.boolean  "turned_on"
    t.float    "brightness",         limit: 24
    t.float    "hue",                limit: 24
    t.string   "type",               limit: 255
    t.integer  "eco_tower_id",       limit: 4
    t.float    "target_temperature", limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wall_switch_id",     limit: 4
    t.integer  "on_mask",            limit: 4,     default: 0
    t.integer  "change_mask",        limit: 4,     default: 0
    t.integer  "mode",               limit: 4
    t.integer  "generic_module_id",  limit: 4
    t.string   "info",               limit: 255
    t.text     "stash",              limit: 65535
  end

  create_table "scenarios", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "zone_id",    limit: 4,   default: 0
    t.boolean  "hidden",                 default: false
    t.integer  "house_id",   limit: 4
    t.integer  "scene_id",   limit: 4
  end

  add_index "scenarios", ["deleted_at"], name: "index_scenarios_on_deleted_at", using: :btree

  create_table "scene_configs", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.integer  "hotel_id",           limit: 4
    t.string   "content",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hotel_room_type_id", limit: 4
  end

  create_table "scenes", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "usage",          limit: 20
    t.string   "usage_category", limit: 20
    t.integer  "usage_id",       limit: 4
    t.text     "content",        limit: 65535
    t.string   "describe",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "room_type_id",   limit: 4
  end

  create_table "sharing_keys", force: :cascade do |t|
    t.string   "source",         limit: 255
    t.integer  "shareable_id",   limit: 4
    t.string   "shareable_type", limit: 255
    t.string   "code",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "owner_id",       limit: 4
    t.datetime "starts_at"
    t.datetime "expires_at"
    t.integer  "remaining",      limit: 4,   default: 0
    t.datetime "open_at"
  end

  create_table "shipping_infos", force: :cascade do |t|
    t.integer  "user_id",                  limit: 4
    t.string   "receiver_name",            limit: 255
    t.string   "address_province",         limit: 255
    t.string   "address_city",             limit: 255
    t.string   "address_district",         limit: 255
    t.string   "address_street",           limit: 255
    t.string   "zip_code",                 limit: 255
    t.string   "cell_phone",               limit: 255
    t.string   "phone",                    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "default_shipping_user_id", limit: 4
    t.datetime "deleted_at"
  end

  add_index "shipping_infos", ["deleted_at"], name: "index_shipping_infos_on_deleted_at", using: :btree
  add_index "shipping_infos", ["user_id"], name: "index_shipping_infos_on_user_id", using: :btree

  create_table "shopping_carts", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "simple_captcha_data", force: :cascade do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

  create_table "special_agent_sessions", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.string   "key",            limit: 255, null: false
    t.string   "session_key",    limit: 255, null: false
    t.datetime "last_online_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spices", force: :cascade do |t|
    t.string   "type",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "template",       limit: 255
    t.integer  "recipe_step_id", limit: 4
    t.string   "filter",         limit: 255
    t.integer  "recipe_id",      limit: 4
  end

  add_index "spices", ["recipe_id"], name: "index_spices_on_recipe_id", using: :btree
  add_index "spices", ["recipe_step_id"], name: "index_spices_on_recipe_step_id", using: :btree

  create_table "statistic_items", force: :cascade do |t|
    t.datetime "time"
    t.integer  "obj_id",     limit: 4
    t.string   "obj_type",   limit: 255
    t.string   "type",       limit: 255
    t.integer  "value",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggestion_parameters", force: :cascade do |t|
    t.integer "suggestion_id", limit: 4
    t.string  "key",           limit: 255
    t.string  "value",         limit: 255
  end

  create_table "suggestions", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "type",       limit: 255
    t.boolean  "pushed",                 default: false
    t.boolean  "read",                   default: false
    t.boolean  "deleted",                default: false
    t.integer  "clicks",     limit: 4,   default: 0
    t.datetime "pushed_at"
    t.datetime "read_at"
    t.datetime "clicked_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "address",     limit: 255
    t.integer  "prepare_day", limit: 4
    t.string   "code",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "switch_bulbs", force: :cascade do |t|
    t.integer  "switch_id",  limit: 4
    t.integer  "bulb_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "switch_bulbs", ["bulb_id"], name: "index_switch_bulbs_on_bulb_id", using: :btree
  add_index "switch_bulbs", ["switch_id"], name: "index_switch_bulbs_on_switch_id", using: :btree

  create_table "switches", force: :cascade do |t|
    t.integer  "device_info_id",   limit: 4
    t.integer  "user_id",          limit: 4
    t.integer  "router_id",        limit: 4
    t.string   "name",             limit: 255
    t.boolean  "turned_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "house_id",         limit: 4
    t.integer  "mode",             limit: 4,   default: 1,    null: false
    t.float    "brightness1",      limit: 24
    t.float    "hue1",             limit: 24
    t.float    "brightness2",      limit: 24
    t.float    "hue2",             limit: 24
    t.float    "brightness3",      limit: 24
    t.float    "hue3",             limit: 24
    t.integer  "scenario1_id",     limit: 4
    t.integer  "scenario2_id",     limit: 4
    t.integer  "scenario3_id",     limit: 4
    t.integer  "scenario4_id",     limit: 4
    t.integer  "start_night_time", limit: 4,   default: 1200
    t.integer  "end_night_time",   limit: 4,   default: 420
    t.integer  "channel",          limit: 4
    t.integer  "wall_switch_id",   limit: 4
    t.integer  "position",         limit: 4,   default: 9999
    t.integer  "scene_a_id",       limit: 4
    t.integer  "scene_b_id",       limit: 4
    t.integer  "scene_c_id",       limit: 4
    t.integer  "scene_d_id",       limit: 4
  end

  add_index "switches", ["device_info_id"], name: "index_switches_on_device_info_id", using: :btree
  add_index "switches", ["house_id"], name: "index_switches_on_house_id", using: :btree
  add_index "switches", ["router_id"], name: "index_switches_on_router_id", using: :btree
  add_index "switches", ["user_id"], name: "index_switches_on_user_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tcplog_tasks", force: :cascade do |t|
    t.string   "state",        limit: 255,   default: "created"
    t.string   "command",      limit: 255
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.datetime "enqueued_at"
    t.datetime "finalized_at"
    t.text     "device_ips",   limit: 65535
    t.text     "op_codes",     limit: 65535
    t.datetime "ran_at"
    t.datetime "begin"
    t.datetime "end"
  end

  create_table "temperature_data", force: :cascade do |t|
    t.integer  "th_sensor_id",     limit: 4
    t.float    "temperature_in_c", limit: 24
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "temperature_data", ["th_sensor_id", "time"], name: "index_temperature_data_on_th_sensor_id_and_time", using: :btree
  add_index "temperature_data", ["th_sensor_id"], name: "index_temperature_data_on_th_sensor_id", using: :btree
  add_index "temperature_data", ["time"], name: "index_temperature_data_on_time", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.string   "notify_id",        limit: 255
    t.float    "total_fee",        limit: 24
    t.string   "trade_status",     limit: 255
    t.string   "trade_no",         limit: 255
    t.datetime "notify_time"
    t.text     "raw_query_string", limit: 65535
    t.string   "buyer_email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source",           limit: 255
    t.string   "order_number",     limit: 255
    t.boolean  "illegal"
  end

  add_index "transactions", ["notify_id"], name: "index_transactions_on_notify_id", using: :btree

  create_table "transforms", force: :cascade do |t|
    t.integer  "device_info_id",     limit: 4
    t.string   "type",               limit: 255
    t.string   "from_vpid",          limit: 255
    t.string   "to_vpid",            limit: 255
    t.string   "md_str",             limit: 255
    t.datetime "md_received_at"
    t.datetime "mr_received_at"
    t.datetime "mc_sent_at"
    t.datetime "quality_checked_at"
    t.string   "state",              limit: 255
    t.string   "inspector",          limit: 255
    t.integer  "last_router",        limit: 8
    t.integer  "device_ip",          limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "step",               limit: 4,   default: 0
    t.string   "qr_code",            limit: 255
    t.string   "mc_result",          limit: 255
  end

  add_index "transforms", ["device_info_id"], name: "index_transforms_on_device_info_id", using: :btree
  add_index "transforms", ["inspector"], name: "index_transforms_on_inspector", using: :btree
  add_index "transforms", ["quality_checked_at"], name: "index_transforms_on_quality_checked_at", using: :btree

  create_table "triggable_scenarios", force: :cascade do |t|
    t.integer  "scenario_id",   limit: 4
    t.string   "trigger_type",  limit: 255
    t.integer  "trigger_id",    limit: 4
    t.integer  "trigger_index", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_apn_devices", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "device_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "user_apn_devices", ["device_id"], name: "index_user_apn_devices_on_device_id", using: :btree
  add_index "user_apn_devices", ["user_id"], name: "index_user_apn_devices_on_user_id", using: :btree

  create_table "user_favorite_recipes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "recipe_id",  limit: 4
    t.boolean  "activated",            default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_groups", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "describe",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_groups_users", id: false, force: :cascade do |t|
    t.integer "user_id",       limit: 4
    t.integer "user_group_id", limit: 4
  end

  add_index "user_groups_users", ["user_group_id"], name: "index_user_groups_users_on_user_group_id", using: :btree
  add_index "user_groups_users", ["user_id"], name: "index_user_groups_users_on_user_id", using: :btree

  create_table "user_keys", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "user_key_index", limit: 4
    t.string   "user_key",       limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "user_logs", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "message",    limit: 255
    t.integer  "timestamp",  limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_preferences", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_recipe_steps", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "recipe_step_id", limit: 4
    t.boolean  "set",                      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_recipe_id", limit: 4
  end

  add_index "user_recipe_steps", ["user_id"], name: "index_user_recipe_steps_on_user_id", using: :btree
  add_index "user_recipe_steps", ["user_recipe_id"], name: "index_user_recipe_steps_on_user_recipe_id", using: :btree

  create_table "user_recipe_triggers", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "user_recipe_id", limit: 4
    t.string   "event",          limit: 255
    t.integer  "device_ip",      limit: 4
    t.string   "command_code",   limit: 255
    t.integer  "time",           limit: 4
    t.string   "worker",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "user_recipe_triggers", ["user_id"], name: "index_user_recipe_triggers_on_user_id", using: :btree
  add_index "user_recipe_triggers", ["user_recipe_id"], name: "index_user_recipe_triggers_on_user_recipe_id", using: :btree

  create_table "user_recipes", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "recipe_id",      limit: 4
    t.boolean  "favorite",                   default: false
    t.boolean  "activate",                   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "deactivate_ids", limit: 255
  end

  add_index "user_recipes", ["user_id"], name: "index_user_recipes_on_user_id", using: :btree

  create_table "user_spices", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.integer  "spice_id",            limit: 4
    t.text     "raw",                 limit: 65535, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_recipe_step_id", limit: 4
  end

  add_index "user_spices", ["spice_id"], name: "index_user_spices_on_spice_id", using: :btree
  add_index "user_spices", ["user_id"], name: "index_user_spices_on_user_id", using: :btree
  add_index "user_spices", ["user_recipe_step_id"], name: "index_user_spices_on_user_recipe_step_id", using: :btree

  create_table "user_users", force: :cascade do |t|
    t.integer "owner_user_id", limit: 4
    t.integer "user_id",       limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                     limit: 255, default: "",     null: false
    t.string   "encrypted_password",        limit: 128, default: "",     null: false
    t.string   "reset_password_token",      limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",        limit: 255
    t.string   "last_sign_in_ip",           limit: 255
    t.string   "confirmation_token",        limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token",      limit: 255
    t.boolean  "admin",                                 default: false
    t.string   "name",                      limit: 255
    t.integer  "failed_attempts",           limit: 4
    t.string   "unlock_token",              limit: 255
    t.datetime "locked_at"
    t.boolean  "factory"
    t.string   "how_did_u_know_us",         limit: 255
    t.string   "leisure_time_interests",    limit: 255
    t.string   "similiar_products_bought",  limit: 255
    t.string   "scenarios_to_use",          limit: 255
    t.string   "needed_features",           limit: 255
    t.string   "needed_products",           limit: 255
    t.string   "encountered_problems",      limit: 255
    t.string   "tone_and_words",            limit: 255
    t.integer  "age",                       limit: 4
    t.boolean  "is_working_force"
    t.integer  "home_are_in_sqm",           limit: 4
    t.string   "location",                  limit: 255
    t.string   "family_background",         limit: 255
    t.boolean  "is_girl"
    t.boolean  "is_renting_a_house"
    t.string   "user_uniq_id",              limit: 255
    t.integer  "transactions_count",        limit: 4,   default: 0,      null: false
    t.integer  "finished_tasks",            limit: 4,   default: 0,      null: false
    t.string   "home_long",                 limit: 255
    t.string   "home_lat",                  limit: 255
    t.integer  "home_leaving_scenario_id",  limit: 4
    t.integer  "home_coming_scenario_id",   limit: 4
    t.string   "home_gaode_long",           limit: 255
    t.string   "home_gaode_lat",            limit: 255
    t.string   "phone",                     limit: 255
    t.integer  "admin_roles",               limit: 4,   default: 0,      null: false
    t.string   "secure_phone",              limit: 255
    t.string   "secure_level",              limit: 255
    t.integer  "secure_level_mask",         limit: 4,   default: 0
    t.string   "type",                      limit: 255, default: "User", null: false
    t.integer  "dealer_promotion_id",       limit: 4
    t.datetime "first_set_secure_phone_at"
    t.string   "home_info",                 limit: 255
    t.boolean  "rename_been_used"
    t.boolean  "guard_been_used"
    t.boolean  "scenario_been_used"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["phone"], name: "index_users_on_phone", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vanke_eco_towers", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.boolean  "turned_on"
    t.integer  "temperature",    limit: 4
    t.integer  "mode",           limit: 4
    t.integer  "fan_speed",      limit: 4
    t.integer  "device_info_id", limit: 4
    t.integer  "user_id",        limit: 4
    t.integer  "router_id",      limit: 4
    t.integer  "house_id",       limit: 4
    t.integer  "position",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vanke_freq_data", force: :cascade do |t|
    t.integer  "user_id",       limit: 4,             null: false
    t.integer  "door_accessor", limit: 4, default: 0
    t.integer  "water_heater",  limit: 4, default: 0
    t.integer  "air_condition", limit: 4, default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vender_products", force: :cascade do |t|
    t.integer  "vid",         limit: 4
    t.integer  "pid",         limit: 4
    t.string   "name",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",     limit: 4
    t.integer  "director_id", limit: 4
  end

  add_index "vender_products", ["vid", "pid"], name: "index_vender_products_on_vid_and_pid", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255,   null: false
    t.integer  "item_id",    limit: 4,     null: false
    t.string   "event",      limit: 255,   null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object",     limit: 65535
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "wall_switch_bulbs", force: :cascade do |t|
    t.string   "state",          limit: 255
    t.integer  "wall_switch_id", limit: 4
    t.integer  "channel",        limit: 4
    t.integer  "sequence",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wall_switch_bulbs_items", force: :cascade do |t|
    t.integer  "wall_switch_bulb_id", limit: 4
    t.integer  "bulb_id",             limit: 4
    t.integer  "wall_switch_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wall_switches", force: :cascade do |t|
    t.integer  "device_info_id",  limit: 4
    t.integer  "user_id",         limit: 4
    t.integer  "router_id",       limit: 4
    t.string   "name",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "house_id",        limit: 4
    t.integer  "mode",            limit: 4,   default: 1,    null: false
    t.boolean  "turned_on_1"
    t.boolean  "turned_on_2"
    t.boolean  "turned_on_3"
    t.integer  "position",        limit: 4,   default: 9999
    t.integer  "hyperlink_state", limit: 4,   default: 0
  end

  add_index "wall_switches", ["device_info_id"], name: "index_wall_switches_on_device_info_id", using: :btree
  add_index "wall_switches", ["house_id"], name: "index_wall_switches_on_house_id", using: :btree
  add_index "wall_switches", ["router_id"], name: "index_wall_switches_on_router_id", using: :btree
  add_index "wall_switches", ["user_id"], name: "index_wall_switches_on_user_id", using: :btree

  create_table "web_hooks", force: :cascade do |t|
    t.string   "event_name", limit: 255
    t.text     "url",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wechat_control_history_items", force: :cascade do |t|
    t.integer  "wechat_user_id", limit: 4
    t.integer  "bulb_id",        limit: 4
    t.integer  "scenario",       limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "wechat_orders", force: :cascade do |t|
    t.integer  "trade_number",     limit: 4
    t.integer  "total_fee",        limit: 4
    t.integer  "product_id",       limit: 4
    t.integer  "openid",           limit: 4
    t.string   "trade_type",       limit: 255
    t.string   "goods_tag",        limit: 255
    t.datetime "time_start"
    t.datetime "time_expire"
    t.string   "spbill_create_ip", limit: 255
    t.string   "attach",           limit: 255
    t.string   "detail",           limit: 255
    t.string   "body",             limit: 255
    t.string   "mch_id",           limit: 255
    t.string   "appid",            limit: 255
    t.integer  "device_info",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wechat_scene_qrcodes", force: :cascade do |t|
    t.integer  "expire_seconds", limit: 4
    t.string   "action_name",    limit: 255
    t.string   "action_info",    limit: 255
    t.integer  "scene_id",       limit: 4
    t.string   "scene_str",      limit: 255
    t.string   "usage",          limit: 255
    t.string   "img",            limit: 1000
    t.string   "url",            limit: 1000
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wechat_user_alarms", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "house_id",       limit: 4
    t.integer  "scene_id",       limit: 4
    t.integer  "wechat_user_id", limit: 4
    t.datetime "active_time"
    t.boolean  "enable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "delay_job_id",   limit: 4
  end

  create_table "wechat_user_houses", force: :cascade do |t|
    t.integer  "wechat_user_id",    limit: 4
    t.integer  "house_id",          limit: 4
    t.boolean  "enable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "manage_token",      limit: 255
    t.string   "outside_user_type", limit: 255, default: "wechat"
    t.boolean  "no_share"
  end

  create_table "wechat_users", force: :cascade do |t|
    t.boolean  "subscribe"
    t.string   "openid",     limit: 255
    t.string   "nickname",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "yee_clocks", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "house_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "yee_locks", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "house_id",   limit: 4
    t.string   "yee_uid",    limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zone_devices", force: :cascade do |t|
    t.integer  "device_id",   limit: 4
    t.string   "device_type", limit: 255
    t.integer  "zone_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zones", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "signature",  limit: 4
  end

end
