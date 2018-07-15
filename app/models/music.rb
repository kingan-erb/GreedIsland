class Music < ApplicationRecord
	validates :music_name, presence: true
	validates :disk_number, presence: true
	belongs_to :product
end
