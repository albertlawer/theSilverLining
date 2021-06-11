json.extract! request_master, :id, :user_id, :customer_number, :network, :trans_type, :item_desc, :trans_id, :amount, :status, :callback_status, :resp_code, :resp_desc, :created_at, :updated_at
json.url request_master_url(request_master, format: :json)
