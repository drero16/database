json.extract! notification, :id, :description, :seen, :comment_id, :created_at, :updated_at
json.url notification_url(notification, format: :json)