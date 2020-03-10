json.extract! product, :id, :item_id, :branch_id, :user_id, :amount, :created_at, :updated_at
json.url product_url(product, format: :json)
