class AdministratorsController < ApplicationController
	def index
		@greed = Greed.new
		@greeds = Greed.all
		@products = Product.all
	end

	def create
        @greed = Greed.new(greed_params)
        @greed.save
        redirect_to administrators_path
    end

	def show
	end

	def edit
	end

	def update
	end

	private
	def greed_params
	    params.require(:greed).permit(:greed_type, :greed_image_name)
	end
end
