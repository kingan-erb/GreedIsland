class MusicsController < ApplicationController
	before_action :authenticate_administrator!
##  管理者  ##
	#曲追加作成
	def create
		@product = Product.find(params[:id])
		@music = Music.new(music_params)
		@music.product_id = @product.id
		if  @music.save
			redirect_to edit_product_path(@product.id)
			flash[:notice] = "追加されました"
		else
			redirect_to edit_product_path(@product.id)
			flash[:alert] = "エラーが発生しました"
		end
	end

	private

	def music_params
		params.require(:music).permit(:music_name,:music_number,:disk_number)
	end


end
