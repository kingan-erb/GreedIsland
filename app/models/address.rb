class Address < ApplicationRecord
	belongs_to :user

	validates :user_id, presence: true
	validates :postal_code, presence: true, length: { maximum: 7 }
	validates :address, presence: true

end
