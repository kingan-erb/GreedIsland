class AdministratorsController < ApplicationController

	def index
		if params[:cid]
			@greed = Greed.find(params[:cid])
			@products = @greed.products.order(params[:sort]).order(id: :desc)
		else
			@products = Product.order(params[:sort]).order(id: :desc)
		end
	end

	def show
	end

	def edit
	end

end
