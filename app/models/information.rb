class Information < ActiveRecord::Base
  belongs_to :user
  has_many :images
  has_many :notifications
  accepts_nested_attributes_for :images
  validates :title,:description, presence: true

end
