json.extract! user_log, :id, :u_id, :user_id, :name, :branch_id, :role_id, :email, :phone1, :phone2, :address, :note, :password, :created_at, :updated_at
json.url user_log_url(user_log, format: :json)
