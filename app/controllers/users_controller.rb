class UsersController < ApplicationController
	def index
	end

	def show
		@user = User.find(current_user.id)
		@addresses = @user.addresses
		@range = @user.addresses.length
		@order = Order.where(user_id: current_user.id)
		@order_items = OrderItem.where(order_id: @order.id)
	end

	def edit
		@user = User.find(params[:id])
		@addresses = @user.addresses
		@addressnew = Address.new
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
		   redirect_to user_path(@user.id)
		   flash[:notice] = "更新されました"
		else
		   redirect_to user_path(@user.id)
		   flash[:alert] = "エラーが発生しました"
		end
	end


	def destroy
		@user = User.find(params[:id])
		@user.soft_delete
		sign_out(@user)
		if administrator_signed_in?
			redirect_to admin_user_index_path
			flash[:notice] = "削除されました"
		else
			redirect_to greeds_path
			flash[:notice] = "退会しました"
		end
	end

	def admin_index
		@users = User.search(params[:search]).order(params[:sort]).order(id: :desc)
		@navi = params[:sort]
		@total = User.where(deleted_at: nil).length
	end
	def admin_show
		@user = User.find(params[:id])
		@addresses = @user.addresses
		@range = @user.addresses.length
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
		   redirect_to admin_user_index_path
		   flash[:alert] = "エラーが発生しました"
		end
	end
	def address_update
		@user = User.find(params[:id])
		@user.update(:default_address => params[:sort])
		redirect_to admin_user_path(@user.id)
	end

	def password_edit
		@user = User.find(current_user.id)
	end

	def password_update
	    @user = User.find(current_user.id)
	    if @user.update_with_password(user_params)
	      # Sign in the user by passing validation in case their password changed
	      bypass_sign_in(@user)
	      flash[:notice] = "パスワードを変更しました"
	      redirect_to user_path
	    else
	      flash[:notice] = "パスワードが正しく設定されていません"
	      redirect_to password_edit_path
	    end
	end
	def service
	end

	def privacy
	end

	def contact
	end

  	private

	def user_params
	params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number,
	                             :email, :password, :password_confirmation, :current_password, :greed_id, :customer_status, :payment_method,
	                             :default_address,
	                             addresses_attributes: [:id, :postal_code, :address, :user_id, :_destroy])
	end

end
