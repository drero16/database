class Event < ActiveRecord::Base
  belongs_to :user
  has_many :images, :dependent => :destroy
  has_many :notifications
  accepts_nested_attributes_for :images

end
