class Music < ApplicationRecord
	validates :music_name, presence: true
	validates :music_number, presence: true
	validates :disk_number, presence: true
	validates :product_id, presence: true
end
