json.extract! user, :id, :name, :address, :phone, :sex, :role_id, :created_at, :updated_at
json.url user_url(user, format: :json)