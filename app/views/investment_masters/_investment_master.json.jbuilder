json.extract! investment_master, :id, :user_id, :amount_invested, :transaction_code, :start_date, :end_date, :status, :created_at, :updated_at
json.url investment_master_url(investment_master, format: :json)
