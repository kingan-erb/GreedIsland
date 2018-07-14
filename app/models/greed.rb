class Greed < ApplicationRecord
	has_many :users
	# has_many :products
	attachment :greed_image_name
end
