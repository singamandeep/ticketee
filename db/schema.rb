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

ActiveRecord::Schema.define(version: 20180403165046) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string   "file"
    t.integer  "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_attachments_on_ticket_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.integer  "ticket_id"
    t.integer  "author_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "state_id"
    t.integer  "previous_state_id"
    t.index ["author_id"], name: "index_comments_on_author_id", using: :btree
    t.index ["previous_state_id"], name: "index_comments_on_previous_state_id", using: :btree
    t.index ["state_id"], name: "index_comments_on_state_id", using: :btree
    t.index ["ticket_id"], name: "index_comments_on_ticket_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "role"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_roles_on_project_id", using: :btree
    t.index ["user_id"], name: "index_roles_on_user_id", using: :btree
  end

  create_table "states", force: :cascade do |t|
    t.string  "name"
    t.string  "color"
    t.boolean "default", default: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  create_table "tags_tickets", id: false, force: :cascade do |t|
    t.integer "tag_id",    null: false
    t.integer "ticket_id", null: false
    t.index ["tag_id", "ticket_id"], name: "index_tags_tickets_on_tag_id_and_ticket_id", using: :btree
    t.index ["ticket_id", "tag_id"], name: "index_tags_tickets_on_ticket_id_and_tag_id", using: :btree
  end

  create_table "ticket_watchers", id: false, force: :cascade do |t|
    t.integer "ticket_id", null: false
    t.integer "user_id",   null: false
    t.index ["ticket_id", "user_id"], name: "index_ticket_watchers_on_ticket_id_and_user_id", using: :btree
    t.index ["user_id", "ticket_id"], name: "index_ticket_watchers_on_user_id_and_ticket_id", using: :btree
  end

  create_table "tickets", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "author_id"
    t.integer  "state_id"
    t.index ["author_id"], name: "index_tickets_on_author_id", using: :btree
    t.index ["project_id"], name: "index_tickets_on_project_id", using: :btree
    t.index ["state_id"], name: "index_tickets_on_state_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.datetime "archived_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "comments", "states"
  add_foreign_key "comments", "states", column: "previous_state_id"
  add_foreign_key "comments", "tickets"
  add_foreign_key "comments", "users", column: "author_id"
  add_foreign_key "roles", "projects"
  add_foreign_key "roles", "users"
  add_foreign_key "tickets", "projects"
  add_foreign_key "tickets", "states"
  add_foreign_key "tickets", "users", column: "author_id"
end
