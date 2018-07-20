class Greed < ApplicationRecord
	has_many :users
	has_many :products
	attachment :greed_image_name

	validates :greed_type, presence: true
	validates :greed_image_name, presence: true

end
