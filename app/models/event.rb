class Event < ActiveRecord::Base
  belongs_to :user
  has_many :images, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  accepts_nested_attributes_for :images
  validates :title,:description,:date_event,:location,:user_id,presence: true
  geocoded_by :location
  after_validation :geocode  


end
