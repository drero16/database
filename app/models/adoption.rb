class Adoption < ActiveRecord::Base
	self.table_name = 'pets'
	  belongs_to :user
  belongs_to :race
  has_many :comments, :dependent => :destroy
  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :comments,:images
end
