class Adoption < ActiveRecord::Base
	  belongs_to :user
  belongs_to :race
  has_many :comments, :dependent => :destroy
  has_many :images, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  accepts_nested_attributes_for :comments,:images
  validates :animal_type,:sex,:lost_in,:description,:user_id,:race_id, presence: true
  validates :age, :inclusion => 0..40, allow_nil: true
  scope :animal_type, -> (animal_type) { where animal_type: animal_type }
  scope :sex, -> (sex) { where sex: sex }
  scope :race, -> (race) {where race_id: race}
  scope :lost_in, ->(lost_in) {where("DATE(created_at)= lost_in(?)",lost_in)}
  geocoded_by :lost_in
  after_validation :geocode
end
