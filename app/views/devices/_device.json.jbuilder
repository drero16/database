json.extract! device, :id, :user_agent, :endpoint, :p256dh, :auth, :user_id, :created_at, :updated_at
json.url device_url(device, format: :json)