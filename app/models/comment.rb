class Comment < ActiveRecord::Base
  belongs_to :animal
  belongs_to :pet
  belongs_to :user
  has_many :notifications, :dependent => :destroy
  validates :description, :user_id, presence: true

# validate :animal_or_pet

# private
# 	def animal_or_pet
# 	unless animal_id.blank? ^ pet_id.blank?
#        errors.add(:base, "Specify a charge or a payment, not both")
#    end
#end
end
