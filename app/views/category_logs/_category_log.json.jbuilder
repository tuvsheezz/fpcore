json.extract! category_log, :id, :category_id, :user_id, :name, :note, :created_at, :updated_at
json.url category_log_url(category_log, format: :json)
