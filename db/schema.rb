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

ActiveRecord::Schema.define(version: 2018_07_10_123935) do

  create_table "musics", force: :cascade do |t|
    t.string "music_name", null: false
    t.integer "music_number", null: false
    t.integer "disk_number", limit: 4, null: false
    t.integer "product_id", default: 0, null: false
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

end
