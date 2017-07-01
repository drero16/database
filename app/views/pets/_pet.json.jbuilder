json.extract! pet, :id, :animal_type, :age, :sex, :name, :description, :lost_on, :lost_in, :user_id, :race_id, :created_at, :updated_at
json.url pet_url(pet, format: :json)