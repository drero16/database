class Race < ActiveRecord::Base
	has_many :animals
	has_many :pets
end
