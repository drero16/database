class Pet < ActiveRecord::Base
	self.table_name = 'pets'
	default_scope { where(animal_state: 0) }
  belongs_to :user
  belongs_to :race
  has_many :comments, :dependent => :destroy
  has_many :images, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  accepts_nested_attributes_for :comments,:images

end
