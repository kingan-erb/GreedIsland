class Product < ApplicationRecord

	has_many :musics
	# accept_nested_attributes_for :musics
end
