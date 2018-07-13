class MusicsController < ApplicationController


	def new
		@music = Music.new
		maxid = Product.maximum(:id)

		@music.product_id = maxid #musics#newページでの確認用
		@product = Product.find_by(id: maxid)

		if @product.musics.exists?
			@musics = Music.all.where(product_id: maxid)
		end
		logger.debug(@music.product_id)
	end

	# def create
	# 	music = Music.new(music_params)
	# 	if music.save
	# 		# @product = Product.new(product_params)
	# 		@musics = Music.all
	# 		@flag = 1
	# 		logger.debug music.errors.inspect
	# 		redirect_to new_product_path
	# 	else #今のところ処理は一緒だが書いておく
	# 		# @product = Product.new(product_params)
	# 		@musics = Music.all
	# 		@flag = 0
	# 		logger.debug music.errors.inspect
	# 		redirect_to products_path
	# 	end
	# end

 	def create
 		music = Music.new(music_params)
 		maxid = Product.maximum(:id)

 		music.product_id = maxid
 		if music.save
 			music.music_number = music.id
 			music.save #music_numberをsave
 			redirect_to admin_new_music_path
 			logger.debug(music.product_id)
 		else
 			redirect_to products_path
 		end
 	end
 	# 	music.product_id = product.id
 	# 	logger.debug(music.product_id)
 	# end


	def update
	end

	def destroy
		music = Music.find(params[:id])
		music.destroy
		redirect_to admin_new_music_path
	end


	private

	def music_params
		params.require(:music).permit(:music_name,:music_number,:disk_number)
	end

	def id_params
    params.require(:product).permit(:id)
  	end

end
