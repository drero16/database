json.extract! event, :id, :title, :description, :date_event, :location, :user_id, :created_at, :updated_at
json.url event_url(event, format: :json)