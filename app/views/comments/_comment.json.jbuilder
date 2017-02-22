json.extract! comment, :id, :description, :animal_id, :pet_id, :user_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)