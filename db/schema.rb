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

ActiveRecord::Schema.define(version: 2019_06_16_122547) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "branch_logs", force: :cascade do |t|
    t.string "branch_id"
    t.string "user_id"
    t.string "name"
    t.string "address"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "branches", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_logs", force: :cascade do |t|
    t.integer "category_id"
    t.integer "user_id"
    t.string "name"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "currency_name"
  end

  create_table "debts", force: :cascade do |t|
    t.integer "sale_id"
    t.integer "user_id"
    t.integer "branch_id"
    t.decimal "remainder", default: "0.0", null: false
    t.decimal "paid", default: "0.0", null: false
    t.decimal "amount", default: "0.0", null: false
    t.text "note"
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_debts_on_branch_id"
    t.index ["sale_id"], name: "index_debts_on_sale_id"
    t.index ["user_id"], name: "index_debts_on_user_id"
  end

  create_table "dollar_logs", force: :cascade do |t|
    t.integer "dollar_id"
    t.integer "user_id"
    t.string "note"
    t.decimal "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "factoryreturns", force: :cascade do |t|
    t.integer "item_id"
    t.boolean "sent", default: false
    t.datetime "datesent"
    t.boolean "reced", default: false
    t.datetime "detarec"
    t.boolean "gave", default: false
    t.date "dategave"
    t.text "note"
    t.integer "user_id"
    t.boolean "from", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_factoryreturns_on_item_id"
  end

  create_table "item_logs", force: :cascade do |t|
    t.integer "item_id"
    t.string "name"
    t.integer "user_id"
    t.string "bar"
    t.integer "subcategory_id"
    t.decimal "price"
    t.decimal "maxp"
    t.decimal "minp"
    t.integer "minimum"
    t.integer "currency_id"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.string "name_mn"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.integer "subcategory_id"
    t.decimal "price", null: false
    t.decimal "maxp", null: false
    t.decimal "minp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "currency_id"
    t.integer "minimum", default: 0
    t.integer "status_id", default: 1
    t.text "spec", default: "", null: false
    t.string "name_mn", default: "", null: false
    t.decimal "specialp", default: "0.0"
    t.boolean "special_flag", default: false
    t.string "bar"
    t.index ["subcategory_id"], name: "index_items_on_subcategory_id"
  end

  create_table "machigainaoshis", force: :cascade do |t|
    t.integer "item_id"
    t.integer "product_id"
    t.integer "branch_id"
    t.integer "nybo_id"
    t.integer "seller_id"
    t.integer "admin_id"
    t.decimal "amount"
    t.boolean "pre_stat", null: false
    t.boolean "check", null: false
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_machigainaoshis_on_branch_id"
    t.index ["item_id"], name: "index_machigainaoshis_on_item_id"
    t.index ["product_id"], name: "index_machigainaoshis_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "name", null: false
    t.string "bar", null: false
    t.boolean "check", default: false, null: false
    t.string "price", default: "0", null: false
    t.datetime "recieved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prodchanges", force: :cascade do |t|
    t.integer "branch_id"
    t.integer "user_id"
    t.integer "product_id"
    t.decimal "change"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_prodchanges_on_branch_id"
    t.index ["product_id"], name: "index_prodchanges_on_product_id"
    t.index ["user_id"], name: "index_prodchanges_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "item_id"
    t.integer "branch_id"
    t.integer "user_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pre_amount", default: 0
    t.index ["branch_id"], name: "index_products_on_branch_id"
    t.index ["item_id"], name: "index_products_on_item_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "ratedollars", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.decimal "rate"
  end

  create_table "rateyuans", force: :cascade do |t|
    t.decimal "rate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "en", null: false
    t.string "mn", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales", force: :cascade do |t|
    t.integer "branch_id"
    t.integer "user_id"
    t.boolean "noat", default: false
    t.decimal "tax", default: "0.0", null: false
    t.integer "salestatus_id"
    t.decimal "remainder", default: "0.0", null: false
    t.decimal "total", default: "0.0", null: false
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_sales_on_branch_id"
    t.index ["user_id"], name: "index_sales_on_user_id"
  end

  create_table "salestatuses", force: :cascade do |t|
    t.string "en"
    t.string "mn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string "en"
    t.string "mn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "seller_id"
    t.integer "nyabo_id"
    t.integer "branch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stoks", force: :cascade do |t|
    t.integer "stock_id"
    t.integer "item_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_stoks_on_item_id"
    t.index ["stock_id"], name: "index_stoks_on_stock_id"
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name", null: false
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  create_table "subcategory_logs", force: :cascade do |t|
    t.integer "subcategory_id"
    t.integer "user_id"
    t.integer "category_id"
    t.string "name"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taks", force: :cascade do |t|
    t.integer "item_id"
    t.integer "sale_id"
    t.decimal "amount", default: "0.0", null: false
    t.decimal "price", default: "0.0", null: false
    t.decimal "subs", default: "0.0", null: false
    t.decimal "percent", default: "0.0", null: false
    t.decimal "total", default: "0.0", null: false
    t.integer "user_id"
    t.boolean "checker", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_taks_on_item_id"
    t.index ["sale_id"], name: "index_taks_on_sale_id"
    t.index ["user_id"], name: "index_taks_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "sale_id"
    t.integer "item_id"
    t.decimal "amount", default: "0.0", null: false
    t.decimal "total", default: "0.0", null: false
    t.decimal "price", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_tasks_on_item_id"
    t.index ["sale_id"], name: "index_tasks_on_sale_id"
  end

  create_table "trans", force: :cascade do |t|
    t.integer "transfer_id"
    t.integer "item_id"
    t.decimal "amount", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_trans_on_item_id"
    t.index ["transfer_id"], name: "index_trans_on_transfer_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.integer "bto", null: false
    t.integer "bfrom", null: false
    t.integer "uto", null: false
    t.integer "ufrom", null: false
    t.boolean "check", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "checker", default: true
  end

  create_table "user_logs", force: :cascade do |t|
    t.integer "u_id"
    t.integer "user_id"
    t.string "name"
    t.integer "branch_id"
    t.integer "role_id"
    t.string "email"
    t.string "phone1"
    t.string "phone2"
    t.string "address"
    t.string "note"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.integer "phone", null: false
    t.integer "phone2"
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role_id"
    t.integer "branch_id"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "yuan_logs", force: :cascade do |t|
    t.integer "yuan_id"
    t.integer "user_id"
    t.string "note"
    t.decimal "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
