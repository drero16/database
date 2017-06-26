class Risk < ActiveRecord::Base
	self.table_name = 'animals'
	default_scope { where(animal_state: 1) }
	belongs_to :user
  belongs_to :race
  has_many :comments, :dependent => :destroy
  has_many :images, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  accepts_nested_attributes_for :comments,:images
  validates :risk_type,:sex,:location,:description,:user_id,:race_id, presence: true
  scope :race, -> (race) {where race_id: race}
end
