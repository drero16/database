class Risk < ActiveRecord::Base
	self.table_name = 'animals'
	belongs_to :user
  belongs_to :race
  has_many :comments, :dependent => :destroy
  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :comments,:images
  validates :risk_type,:sex,:location,:description,:user_id,:race_id, presence: true
end
