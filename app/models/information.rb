class Information < ActiveRecord::Base
  belongs_to :user
  has_many :images
  has_many :notifications
end
