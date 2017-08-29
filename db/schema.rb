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

ActiveRecord::Schema.define(version: 20170823135849) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.bigint "creator_id"
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "board_id"
    t.boolean "enabled"
    t.index ["board_id"], name: "index_chats_on_board_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "board_id"
    t.bigint "invitor_id"
    t.bigint "user_to_invite_id"
    t.boolean "accepted", default: false
    t.index ["board_id"], name: "index_invitations_on_board_id"
  end

  create_table "invited_user_permissions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "board_id"
    t.boolean "create_message", default: true
    t.boolean "create_note", default: true
    t.boolean "edit_note", default: true
    t.boolean "delete_note", default: true
    t.boolean "move_note_to_other_list", default: true
    t.boolean "create_list", default: true
    t.boolean "edit_list_name", default: true
    t.boolean "delete_list", default: true
    t.boolean "freeze_list", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_invited_user_permissions_on_board_id"
    t.index ["user_id"], name: "index_invited_user_permissions_on_user_id"
  end

  create_table "lists", force: :cascade do |t|
    t.bigint "board_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_disabled"
    t.index ["board_id"], name: "index_lists_on_board_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "text"
    t.bigint "user_id"
    t.bigint "chat_id"
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "text"
    t.index ["list_id"], name: "index_notes_on_list_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.string "phone"
    t.bigint "user_id"
    t.integer "sex"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "user_boards", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "board_id"
    t.index ["board_id"], name: "index_user_boards_on_board_id"
    t.index ["user_id"], name: "index_user_boards_on_user_id"
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
    t.integer "role", default: 1
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "invitations", "users", column: "invitor_id"
  add_foreign_key "invitations", "users", column: "user_to_invite_id"
end
