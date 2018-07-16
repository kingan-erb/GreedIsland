class UsersController < ApplicationController
	def index
	end

	def show
		@user = User.find(current_user.id)
		@addresses = @user.addresses
	end

	def edit
	end

	def update
	end

	def soft_delete
	end

	def admin_index
		@users = User.search(params[:search]).order(params[:sort]).order(id: :desc)
		@navi = params[:sort]
	end
end
