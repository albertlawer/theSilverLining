json.extract! payment_table, :id, :user_id, :referer_user_id, :investment_master_code, :client_profit, :referer_profit, :admin_profit, :status, :created_at, :updated_at
json.url payment_table_url(payment_table, format: :json)
