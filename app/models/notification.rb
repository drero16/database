class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :animal
  belongs_to :adoption
  belongs_to :comment
  belongs_to :pet
  belongs_to :risk
end
