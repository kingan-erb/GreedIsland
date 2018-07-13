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

ActiveRecord::Schema.define(version: 2018_07_13_031906) do

  create_table "addresses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "postal_code", limit: 7, null: false
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "administrators", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_administrators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "product_id", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "greeds", force: :cascade do |t|
    t.string "greed_type", null: false
    t.string "greed_image_name_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["greed_type"], name: "index_greeds_on_greed_type"
  end

  create_table "musics", force: :cascade do |t|
    t.string "music_name", null: false
    t.integer "music_number"
    t.integer "disk_number", limit: 4, null: false
    t.integer "product_id", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "product_id", null: false
    t.string "o_artist_name", null: false
    t.string "o_product_name", null: false
    t.string "o_product_image_name_id", null: false
    t.integer "o_price", null: false
    t.integer "o_greed_id", null: false
    t.integer "o_quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["o_greed_id"], name: "index_order_items_on_o_greed_id"
    t.index ["o_product_name"], name: "index_order_items_on_o_product_name"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "order_date", null: false
    t.integer "payment_method", null: false
    t.datetime "delivery_date", null: false
    t.integer "delivery_time", null: false
    t.string "delivery_address", null: false
    t.integer "delivery_status", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "artist_name", null: false
    t.string "product_name", null: false
    t.string "product_image_name_id", null: false
    t.integer "price", null: false
    t.integer "label_name", null: false
    t.integer "genre_name", null: false
    t.integer "inventry_status", null: false
    t.integer "sales_quantity", default: 0, null: false
    t.integer "greed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["greed_id"], name: "index_products_on_greed_id"
    t.index ["product_name"], name: "index_products_on_product_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "last_name_kana", null: false
    t.string "first_name_kana", null: false
    t.integer "phone_number", null: false
    t.integer "greed_id", null: false
    t.integer "customer_status", limit: 1, default: 0, null: false
    t.integer "payment_method", limit: 1, default: 0, null: false
    t.integer "default_address", default: 1, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_users_on_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["greed_id"], name: "index_users_on_greed_id"
    t.index ["last_name"], name: "index_users_on_last_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
