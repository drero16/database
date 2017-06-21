json.extract! notification, :id, :titulo, :mensaje, :url, :seen, :pic_url
json.url notification_url(notification, format: :json)