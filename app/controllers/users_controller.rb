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


	def destroy
		@user = User.find(params[:id])
		@user.soft_delete
		#current_user
		#sign_out(@user)
		#else administrator
		redirect_to admin_users_path
        flash[:notice] = "削除されました"
        #end
	end

	def admin_index
		@users = User.search(params[:search]).order(params[:sort]).order(id: :desc)
		@navi = params[:sort]
	end
	def admin_show
		@user = User.find(params[:id])
		@addresses = @user.addresses
	end
	def admin_edit
		@user = User.find(params[:id])
		@addresses = @user.addresses
		@addressnew = Address.new
	end

	def admin_update
    	@user = User.find(params[:id])
		if @user.update(user_params)
		   redirect_to admin_user_path(@user.id)
		   flash[:notice] = "更新されました"
		else
		   redirect_to greeds_path
		   flash[:alert] = "エラーが発生しました"
		end
	end
  	private

	def user_params
	params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number,
	                             :email, :password, :password_confirmation, :greed_id, :customer_status, :payment_method,
	                             :default_address,
	                             addresses_attributes: [:id, :postal_code, :address, :user_id, :_destroy])
	end

end
