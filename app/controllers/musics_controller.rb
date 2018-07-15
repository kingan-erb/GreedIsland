class MusicsController < ApplicationController


	def new
	end

	def create
		@product = Product.find(params[:id])
		@music = Music.new(music_params)
		@music.product_id = @product.id
		@music.save
		redirect_to edit_product_path(@product.id)
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
