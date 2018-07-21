class GreedsController < ApplicationController
before_action :authenticate_administrator!, except: [:index]

##  ユーザー  ##
	#トップページ
 	def index
 		@greeds = Greed.all
 		@greed_flag = true#ヘッダー、フッター非表示
  	end

##  管理者  ##
	#カテゴリー新規作成ページ
	def new
		@greed = Greed.new
		@greeds = Greed.all
	end
  	#カテゴリー新規作成
  	def create
  		@greed = Greed.new(greed_params)
  		if @greed.save
  			redirect_to new_greed_path
  			flash[:notice] = "作成されました"
  		else
  			redirect_to new_greed_path
  			flash[:alert] = "エラーが発生しました"
  		end
  	end
  	#カテゴリー更新
  	def update
		@greed = Greed.find(params[:id])
		if 	@greed.update(greed_params)
			redirect_to new_greed_path
			flash[:notice] = "更新されました"
		else
			redirect_to new_greed_path
  			flash[:alert] = "エラーが発生しました"
  		end
	end
  	#カテゴリー削除
	def destroy
		@greed = Greed.find(params[:id])
		if 	@greed.destroy
			redirect_to new_greed_path
			flash[:notice] = "削除されました"
	    else
	    	redirect_to new_greed_path
  			flash[:alert] = "エラーが発生しました"
  		end
	end

	private

	def greed_params
	 	params.require(:greed).permit(:greed_type,:greed_image_name)
	end

end
