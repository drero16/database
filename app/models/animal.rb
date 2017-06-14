class Animal < ActiveRecord::Base
	self.table_name = 'animals'
  belongs_to :user
  belongs_to :race
  has_many :comments, :dependent => :destroy
  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :comments,:images
  validates :animal_type,:sex,:location,:description,:user_id,:race_id, presence: true
  scope :animal_type, -> (animal_type) { where animal_type: animal_type }
  scope :sex, -> (sex) { where sex: sex }
  scope :race, -> (race) {where race_id: race}
  scope :date, ->(date) {where("DATE(created_at)= date(?)",date)}
  geocoded_by :location
  after_validation :geocode
end
