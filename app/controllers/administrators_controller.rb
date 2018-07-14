class AdministratorsController < ApplicationController
	def new
		@greed = Greed.new
		@greeds = Greed.all
	end
	def index
		@products = Product.all
	end

	def create
        @greed = Greed.new(greed_params)
        @greed.save
        redirect_to new_administrator_path
  end

	def show
	end

	def edit
	end

	def update
		@greed = Greed.find(params[:id])
		@greed.update(greed_params)
		redirect_to new_administrator_path
		flash[:notice] = "更新されました"
	end

	def destroy
		@greed = Greed.find(params[:id])
		@greed.destroy
		redirect_to new_administrator_path
		flash[:notice] = "削除されました"
	end

	private
	def greed_params
	    params.require(:greed).permit(:greed_type, :greed_image_name)
	end
end
