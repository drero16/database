class Race < ActiveRecord::Base
	has_many :animals
	has_many :pets
	accepts_nested_attributes_for :animals,:pets
end
