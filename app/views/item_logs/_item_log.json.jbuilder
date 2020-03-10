json.extract! item_log, :id, :item_id, :name, :user_id, :bar, :subcategory_id, :price, :maxp, :minp, :minimum, :currency_id, :note, :created_at, :updated_at
json.url item_log_url(item_log, format: :json)
