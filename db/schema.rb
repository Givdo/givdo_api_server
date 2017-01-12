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

ActiveRecord::Schema.define(version: 20161016194656) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.integer  "subject_id"
    t.string   "subject_type"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "activities", ["subject_type", "subject_id"], name: "index_activities_on_subject_type_and_subject_id"
  add_index "activities", ["user_id"], name: "index_activities_on_user_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "answers", force: :cascade do |t|
    t.integer  "trivia_option_id"
    t.datetime "updated_at",                       null: false
    t.boolean  "correct",          default: false, null: false
    t.integer  "trivia_id"
    t.integer  "player_id"
  end

  add_index "answers", ["player_id"], name: "index_answers_on_player_id"
  add_index "answers", ["trivia_option_id"], name: "index_answers_on_trivia_option_id"

  create_table "badges", force: :cascade do |t|
    t.string   "name"
    t.integer  "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "badges", ["score"], name: "index_badges_on_score"

  create_table "badges_users", id: false, force: :cascade do |t|
    t.integer "user_id",  null: false
    t.integer "badge_id", null: false
  end

  add_index "badges_users", ["badge_id", "user_id"], name: "index_badges_users_on_badge_id_and_user_id", unique: true

  create_table "beta_accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "granted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
  end

  add_index "beta_accesses", ["email"], name: "index_beta_accesses_on_email", unique: true

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "causes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "causes_users", id: false, force: :cascade do |t|
    t.integer "user_id",  null: false
    t.integer "cause_id", null: false
  end

  add_index "causes_users", ["user_id", "cause_id"], name: "index_causes_users_on_user_id_and_cause_id"

  create_table "cycle_scores", force: :cascade do |t|
    t.integer  "score"
    t.integer  "cycle_id"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "cycle_scores", ["cycle_id"], name: "index_cycle_scores_on_cycle_id"
  add_index "cycle_scores", ["organization_id"], name: "index_cycle_scores_on_organization_id"

  create_table "cycles", force: :cascade do |t|
    t.datetime "ended_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string   "token"
    t.string   "platform"
    t.boolean  "enabled",    default: true
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id"

  create_table "games", force: :cascade do |t|
    t.integer  "creator_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "single",      default: true
    t.integer  "category_id"
  end

  add_index "games", ["creator_id"], name: "index_games_on_creator_id"

  create_table "games_trivia", id: false, force: :cascade do |t|
    t.integer "game_id"
    t.integer "trivia_id"
  end

  create_table "games_users", id: false, force: :cascade do |t|
    t.integer "game_id"
    t.integer "user_id"
  end

  add_index "games_users", ["game_id"], name: "index_games_users_on_game_id"
  add_index "games_users", ["user_id"], name: "index_games_users_on_user_id"

  create_table "notifications", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.integer  "sender_id"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "notifications", ["game_id"], name: "index_notifications_on_game_id"
  add_index "notifications", ["sender_id"], name: "index_notifications_on_sender_id"
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "organization_score_reports", force: :cascade do |t|
    t.integer  "score"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "organization_score_reports", ["organization_id"], name: "index_organization_score_reports_on_organization_id"

  create_table "organizations", force: :cascade do |t|
    t.string   "facebook_id"
    t.string   "name"
    t.string   "picture"
    t.string   "state"
    t.string   "city"
    t.string   "zip"
    t.string   "street"
    t.string   "mission"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "cached_at"
  end

  create_table "players", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.integer  "organization_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.datetime "finished_at"
    t.integer  "score",           default: 0
  end

  add_index "players", ["game_id"], name: "index_players_on_game_id"
  add_index "players", ["organization_id"], name: "index_players_on_organization_id"
  add_index "players", ["user_id"], name: "index_players_on_user_id"

  create_table "rpush_apps", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "environment"
    t.text     "certificate"
    t.string   "password"
    t.integer  "connections",             default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                                null: false
    t.string   "auth_key"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "access_token"
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id"
  end

  add_index "rpush_feedback", ["device_token"], name: "index_rpush_feedback_on_device_token"

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound",                        default: "default"
    t.text     "alert"
    t.text     "data"
    t.integer  "expiry",                       default: 86400
    t.boolean  "delivered",                    default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                       default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alert_is_json",                default: false
    t.string   "type",                                             null: false
    t.string   "collapse_key"
    t.boolean  "delay_while_idle",             default: false,     null: false
    t.text     "registration_ids"
    t.integer  "app_id",                                           null: false
    t.integer  "retries",                      default: 0
    t.string   "uri"
    t.datetime "fail_after"
    t.boolean  "processing",                   default: false,     null: false
    t.integer  "priority"
    t.text     "url_args"
    t.string   "category"
    t.boolean  "content_available",            default: false
    t.text     "notification"
  end

  add_index "rpush_notifications", ["app_id", "delivered", "failed", "deliver_after"], name: "index_rapns_notifications_multi"
  add_index "rpush_notifications", ["delivered", "failed"], name: "index_rpush_notifications_multi"

  create_table "trivia", force: :cascade do |t|
    t.text     "question"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "correct_option_id"
    t.integer  "category_id"
  end

  create_table "trivia_options", force: :cascade do |t|
    t.string   "text"
    t.integer  "trivia_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",        null: false
    t.string   "uid",             null: false
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "provider_token"
    t.integer  "organization_id"
    t.string   "cover"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true

end
