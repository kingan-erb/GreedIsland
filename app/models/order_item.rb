class OrderItem < ApplicationRecord
	belongs_to :order

	attachment :o_product_image_name

	validates :order_id, presence: true
	validates :product_id, presence: true
	validates :o_artist_name, presence: true
	validates :o_product_name, presence: true
	validates :o_product_image_name, presence: true
	validates :o_price, presence: true
	validates :o_greed_id, presence: true
	validates :o_quantity, presence: true

end
