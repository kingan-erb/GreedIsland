class Product < ApplicationRecord
	validates :artist_name, presence: true
	validates :product_name, presence: true
	validates :product_image_name, presence: true
	validates :price, presence: true
	validates :label_name, presence: true
	validates :genre_name, presence: true
	validates :inventry_status, presence: true
	validates :sales_quantity, presence: true
	validates :greed_id, presence: true

	attachment :product_image_name

	# accept_nested_attributes_for :musics
	has_many :cart_items
	has_many :musics, dependent: :destroy
	accepts_nested_attributes_for :musics, allow_destroy: true
	belongs_to :greed
	def musics
  	return Music.where(product_id: self.id).order(disk_number: :asc).order(music_number: :asc)
  end
end
