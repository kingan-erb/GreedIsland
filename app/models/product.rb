class Product < ApplicationRecord

	has_many :musics
	# accept_nested_attributes_for :musics
	has_many :cart_items
	has_many :order_items
	belongs_to :greed
end
