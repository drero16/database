class Race < ActiveRecord::Base
	has_many :animals
	has_many :pets
	has_many :adoptions
	has_many :risks
	accepts_nested_attributes_for :animals,:pets,:risks,:adoptions
end
