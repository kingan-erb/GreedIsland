class MusicsController < ApplicationController


	def new
	end

	def create
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
