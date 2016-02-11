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

ActiveRecord::Schema.define(version: 20160211021526) do

  create_table "answers", force: :cascade do |t|
    t.integer  "trivia_option_id"
    t.datetime "updated_at",                       null: false
    t.boolean  "correct",          default: false, null: false
    t.integer  "trivia_id"
    t.integer  "player_id"
  end

  add_index "answers", ["player_id"], name: "index_answers_on_player_id"
  add_index "answers", ["trivia_option_id"], name: "index_answers_on_trivia_option_id"

  create_table "beta_accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "granted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "creator_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "rounds",     default: 10
    t.boolean  "single",     default: false
  end

  add_index "games", ["creator_id"], name: "index_games_on_creator_id"

  create_table "games_users", id: false, force: :cascade do |t|
    t.integer "game_id"
    t.integer "user_id"
  end

  add_index "games_users", ["game_id"], name: "index_games_users_on_game_id"
  add_index "games_users", ["user_id"], name: "index_games_users_on_user_id"

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

  create_table "trivia", force: :cascade do |t|
    t.text     "question"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "correct_option_id"
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
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true

end
