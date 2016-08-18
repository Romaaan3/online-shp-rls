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

ActiveRecord::Schema.define(version: 20160527124032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blocks", force: :cascade do |t|
    t.string   "name"
    t.text     "text"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
    t.string   "title"
    t.string   "description"
    t.string   "keywords"
    t.index ["slug"], name: "index_blocks_on_slug", unique: true, using: :btree
  end

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
    t.string   "description"
    t.index ["slug"], name: "index_brands_on_slug", unique: true, using: :btree
  end

  create_table "cart_line_items", force: :cascade do |t|
    t.integer  "part_id"
    t.integer  "cart_id"
    t.integer  "q",          default: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.decimal  "price"
    t.index ["cart_id"], name: "index_cart_line_items_on_cart_id", using: :btree
    t.index ["part_id"], name: "index_cart_line_items_on_part_id", using: :btree
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
    t.string   "description"
    t.index ["slug"], name: "index_categories_on_slug", unique: true, using: :btree
  end

  create_table "cp_leads", force: :cascade do |t|
    t.string   "name"
    t.string   "tel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emails", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.index ["slug"], name: "index_emails_on_slug", unique: true, using: :btree
  end

  create_table "existences", force: :cascade do |t|
    t.integer  "part_id"
    t.integer  "store_id"
    t.integer  "q",          default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["part_id"], name: "index_existences_on_part_id", using: :btree
    t.index ["store_id"], name: "index_existences_on_store_id", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.string   "alt",               default: ""
    t.string   "hint",              default: ""
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "leads", force: :cascade do |t|
    t.string   "name"
    t.string   "tel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.index ["slug"], name: "index_leads_on_slug", unique: true, using: :btree
  end

  create_table "movement_lineitems", force: :cascade do |t|
    t.integer  "part_id"
    t.integer  "movement_id"
    t.integer  "q"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["movement_id"], name: "index_movement_lineitems_on_movement_id", using: :btree
    t.index ["part_id"], name: "index_movement_lineitems_on_part_id", using: :btree
  end

  create_table "movements", force: :cascade do |t|
    t.integer  "from_store_id"
    t.integer  "to_store_id"
    t.text     "description"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "complete",      default: false
    t.string   "slug"
    t.index ["from_store_id"], name: "index_movements_on_from_store_id", using: :btree
    t.index ["slug"], name: "index_movements_on_slug", unique: true, using: :btree
    t.index ["to_store_id"], name: "index_movements_on_to_store_id", using: :btree
  end

  create_table "news", force: :cascade do |t|
    t.string   "name"
    t.string   "anons"
    t.text     "text"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "slug"
    t.index ["slug"], name: "index_news_on_slug", unique: true, using: :btree
  end

  create_table "order_lineitems", force: :cascade do |t|
    t.string   "p_name"
    t.float    "p_cost"
    t.integer  "q"
    t.integer  "part_id"
    t.float    "p_full_cost"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "order_id"
    t.index ["order_id"], name: "index_order_lineitems_on_order_id", using: :btree
    t.index ["part_id"], name: "index_order_lineitems_on_part_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "seller_id"
    t.integer  "client_id"
    t.boolean  "payd"
    t.integer  "from_store_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.float    "full_cost",     default: 0.0
    t.boolean  "complete",      default: false
    t.string   "slug"
    t.string   "name"
    t.string   "mobile"
    t.text     "comment"
    t.string   "familija"
    t.string   "otchestvo"
    t.string   "email"
    t.string   "gorod"
    t.string   "ulica"
    t.string   "dom"
    t.integer  "korpus"
    t.integer  "kv"
    t.string   "postal_index"
    t.string   "tip_dostavki"
    t.string   "tip_oplaty"
    t.index ["client_id"], name: "index_orders_on_client_id", using: :btree
    t.index ["from_store_id"], name: "index_orders_on_from_store_id", using: :btree
    t.index ["seller_id"], name: "index_orders_on_seller_id", using: :btree
    t.index ["slug"], name: "index_orders_on_slug", unique: true, using: :btree
  end

  create_table "parts", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.float    "cost_1"
    t.float    "cost_2"
    t.integer  "brand_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
    t.index ["brand_id"], name: "index_parts_on_brand_id", using: :btree
    t.index ["category_id"], name: "index_parts_on_category_id", using: :btree
    t.index ["slug"], name: "index_parts_on_slug", unique: true, using: :btree
  end

  create_table "pictures", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "part_id"
    t.index ["part_id"], name: "index_pictures_on_part_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.decimal  "rate_of_exchange"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.index ["slug"], name: "index_stores_on_slug", unique: true, using: :btree
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
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "role_id"
    t.string   "slug"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "deleted",                default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["role_id"], name: "index_users_on_role_id", using: :btree
    t.index ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  end

  add_foreign_key "cart_line_items", "carts"
  add_foreign_key "cart_line_items", "parts"
  add_foreign_key "existences", "parts"
  add_foreign_key "existences", "stores"
  add_foreign_key "movement_lineitems", "movements"
  add_foreign_key "movement_lineitems", "parts"
  add_foreign_key "order_lineitems", "orders"
  add_foreign_key "order_lineitems", "parts"
  add_foreign_key "orders", "stores", column: "from_store_id"
  add_foreign_key "orders", "users", column: "client_id"
  add_foreign_key "orders", "users", column: "seller_id"
  add_foreign_key "parts", "brands"
  add_foreign_key "parts", "categories"
  add_foreign_key "pictures", "parts"
  add_foreign_key "users", "roles"
end
