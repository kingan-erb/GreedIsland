class OrderItem < ApplicationRecord
	belongs_to :order

	attachment :o_product_image_name
end
