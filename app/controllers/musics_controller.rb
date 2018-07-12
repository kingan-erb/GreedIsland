class MusicsController < ApplicationController

	def create
		music = Music.new(music_params)
		if music.save
			# @product = Product.new(product_params)
			@musics = Music.all
			@flag = 1
			redirect_to new_product_path
		else #今のところ処理は一緒だが書いておく
			# @product = Product.new(product_params)
			@musics = Music.all
			@flag = 0
			redirect_to new_product_path
		end
	end

	def update
	end

	def destroy
	end


	private

	def music_params
		params.require(:music).permit(:music_name,:music_number,:disk_number)
	end


end
