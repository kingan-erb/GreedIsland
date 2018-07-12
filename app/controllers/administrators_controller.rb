class AdministratorsController < ApplicationController
	def index
		@products = Product.all
	end

	def show
	end

	def edit
	end

	def update
	end
end
