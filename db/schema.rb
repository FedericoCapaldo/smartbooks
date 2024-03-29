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

ActiveRecord::Schema.define(version: 20170312075943) do

  create_table "advertisements", force: :cascade do |t|
    t.string   "title"
    t.decimal  "price"
    t.string   "content"
    t.string   "preferred_contact"
    t.string   "location"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["title", "content"], name: "index_advertisements_on_title_and_content"
    t.index ["user_id", "created_at"], name: "index_advertisements_on_user_id_and_created_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "school"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "password_digest"
    t.string   "password"
    t.string   "password_confirmation"
    t.string   "remember_token"
    t.boolean  "admin",                 default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

end
