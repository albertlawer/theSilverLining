json.extract! system_config, :id, :name, :desc, :value, :status, :created_at, :updated_at
json.url system_config_url(system_config, format: :json)
