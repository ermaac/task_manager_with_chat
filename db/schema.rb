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

ActiveRecord::Schema.define(version: 20170726141351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.integer "profile_id"
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "board_id"
    t.string "enabled"
    t.index ["board_id"], name: "index_chats_on_board_id"
  end

  create_table "disabled_lists", force: :cascade do |t|
    t.bigint "profile_id"
    t.bigint "list_id"
    t.index ["list_id"], name: "index_disabled_lists_on_list_id"
    t.index ["profile_id"], name: "index_disabled_lists_on_profile_id"
  end

  create_table "invitings", force: :cascade do |t|
    t.string "invitor_id"
    t.string "user_to_invite_id"
    t.bigint "board_id"
    t.string "accepted"
    t.index ["board_id"], name: "index_invitings_on_board_id"
  end

  create_table "lists", force: :cascade do |t|
    t.bigint "board_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_lists_on_board_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "text"
    t.bigint "profile_id"
    t.bigint "chat_id"
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["profile_id"], name: "index_messages_on_profile_id"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "list_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "text"
    t.index ["list_id"], name: "index_notes_on_list_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.string "sex"
    t.string "phone"
    t.string "photo_url"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "vk_id"
    t.string "gh_id"
    t.string "facebook_id"
    t.string "google_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
