class Music < ApplicationRecord
	belongs_to :product

	validates :music_name, presence: true
	validates :disk_number, presence: true

end
