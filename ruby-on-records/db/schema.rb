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

ActiveRecord::Schema[8.1].define(version: 2026_01_28_225210) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "dni"
    t.string "email"
    t.string "name"
    t.string "phone"
    t.datetime "updated_at", null: false
    t.index ["dni"], name: "index_clients_on_dni", unique: true
    t.index ["email"], name: "index_clients_on_email"
    t.index ["name"], name: "index_clients_on_name"
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
    t.index ["artist"], name: "index_disks_on_artist"
    t.index ["format"], name: "index_disks_on_format"
    t.index ["price"], name: "index_disks_on_price"
    t.index ["state"], name: "index_disks_on_state"
    t.index ["title"], name: "index_disks_on_title"
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
    t.datetime "created_at", null: false
    t.integer "disk_id", null: false
    t.float "price"
    t.integer "quantity"
    t.integer "sale_id", null: false
    t.datetime "updated_at", null: false
    t.index ["disk_id"], name: "index_items_on_disk_id"
    t.index ["sale_id"], name: "index_items_on_sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.boolean "cancelled", default: false
    t.integer "client_id", null: false
    t.datetime "created_at", null: false
    t.float "total"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["cancelled", "created_at"], name: "index_sales_on_cancelled_and_created_at"
    t.index ["cancelled"], name: "index_sales_on_cancelled"
    t.index ["client_id"], name: "index_sales_on_client_id"
    t.index ["created_at"], name: "index_sales_on_created_at"
    t.index ["user_id"], name: "index_sales_on_user_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "items", "disks"
  add_foreign_key "items", "sales"
  add_foreign_key "sales", "clients"
  add_foreign_key "sales", "users"
end
