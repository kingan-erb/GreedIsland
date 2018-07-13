class CartItem < ApplicationRecord
	belongs_to :users
	belongs_to :products
end
