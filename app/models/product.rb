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
	enum label_name:{マネープロジェクト:0, ハロー！癒し兄弟:1, パワーステップ:2, 食Tunes:3, センチメンタルカラードlove:4}
	enum genre_name:{金POP:0, 癒POP:1, 力POP:2, 食POP:3, 愛POP:4}

end
