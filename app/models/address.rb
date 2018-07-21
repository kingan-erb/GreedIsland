class Address < ApplicationRecord
	belongs_to :user

	validates :postal_code, presence: true
  	validates :address, presence: true
end
