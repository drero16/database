class Animal < ActiveRecord::Base
  belongs_to :user
  belongs_to :race
  has_many :comments, :dependent => :destroy
  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :comments,:images
  validates :animal_type,:sex,:location,:description,:user_id,:race_id, presence: true

  
end
