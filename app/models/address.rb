class Address < ApplicationRecord
	belongs_to :user

	validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  	validates :address, presence: true
end
