# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_11_26_171545) do
  create_table "clients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "dni"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "disks", force: :cascade do |t|
    t.string "artist"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "format"
    t.float "price"
    t.string "state"
    t.integer "stock"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "year"
  end

  create_table "disks_genres", id: false, force: :cascade do |t|
    t.integer "disk_id", null: false
    t.integer "genre_id", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "genre_name"
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales", force: :cascade do |t|
    t.boolean "cancelled"
    t.datetime "created_at", null: false
    t.float "total"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "full_name"
    t.string "password_digest"
    t.integer "role", default: 0, null: false
    t.string "type"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end
end
