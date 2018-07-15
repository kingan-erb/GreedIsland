class Product < ApplicationRecord
	validates :artist_name, presence: true
	validates :product_name, presence: true
	validates :product_image_name, presence: true
	validates :price, presence: true
	validates :label_name, presence: true
	validates :genre_name, presence: true
	validates :inventry_status, presence: true

	validates :greed_id, presence: true

	attachment :product_image_name

	# accept_nested_attributes_for :musics
	has_many :cart_items
	belongs_to :greed

	#enum記述予定
end
