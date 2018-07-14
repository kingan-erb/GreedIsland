class MusicsController < ApplicationController


	def new
	end

	def create
	end

	def update
	end

	def destroy
		music = Music.find(params[:id])
		music.destroy
		@musics = Music.where(product_id: 0)
		redirect_to new_product_path
	end


	private

	def music_params
		params.require(:music).permit(:music_name,:music_number,:disk_number)
	end


end
