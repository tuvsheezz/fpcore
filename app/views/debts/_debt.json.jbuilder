json.extract! debt, :id, :sale_id, :user_id, :branch_id, :remainder, :paid, :amount, :note, :status, :created_at, :updated_at
json.url debt_url(debt, format: :json)
