json.extract! referals_master, :id, :user_id, :refered_user_id, :status, :created_at, :updated_at
json.url referals_master_url(referals_master, format: :json)
