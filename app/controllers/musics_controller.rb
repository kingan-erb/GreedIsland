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
		@music = Music.find(params[:id])
		@music.update(music_params)
		redirect_to edit_product_path(@music.product_id)
		flash[:notice] = "更新されました"
	end

	def destroy
    	@music = Music.find(params[:id])
    	if 	@music.product_id == 0
	    	@music.destroy
	    	redirect_to new_product_path
	      	flash[:notice] = "削除されました"
	    else
	    	@music.destroy
	    	redirect_to edit_product_path(@music.product_id)
	      	flash[:notice] = "削除されました"
	    end
	end


	private

	def music_params
		params.require(:music).permit(:music_name,:music_number,:disk_number)
	end


end
