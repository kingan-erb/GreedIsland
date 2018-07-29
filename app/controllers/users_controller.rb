class UsersController < ApplicationController

#before_action :authenticate_user!
before_action :authenticate_administrator!, only: [:admin_index, :admin_show, :admin_edit, :admin_update]
before_action :ensure_correct_user, only: [:destroy, :address_update, :show, :edit, :update, :password_edit, :password_update]

## 共通　##
	#利用規約
	def service
	end
	#プライバシーポリシー
	def privacy
	end
	#お問い合わせ
	def contact
	end
	#論理削除
	def destroy
		@user = User.find(params[:id])
		@user.soft_delete
		if administrator_signed_in?
			sign_out(@user)
			redirect_to admin_user_index_path
			flash[:notice] = "削除されました"
		elsif user_signed_in?
			sign_out(@user)
			redirect_to greeds_path
			flash[:notice] = "退会しました"
		else
			redirect_to greeds_path
			flash[:alert] = "エラーが発生しました"
		end
	end
	#住所更新
	def address_update
		@user = User.find(params[:id])
		if user_signed_in?
		   @user.update(:default_address => params[:sort])
		   redirect_to user_path(@user.id)
		   flash[:notice] = "変更されました"
		elsif administrator_signed_in?
			@user.update(:default_address => params[:sort])
		    redirect_to admin_show_user_path(@user.id)
		    flash[:notice] = "変更されました"
		else
			redirect_to user_path(@user.id)
			flash[:alert] = "エラーが発生しました"
		end
	end
	#パスワード変更
	def password_edit
		@user = User.find(params[:id])
	end
	#パスワード更新
	def password_update
	    @user = User.find(params[:id])
	    if @user.update_with_password(user_params)
	      	bypass_sign_in(@user)
			flash[:notice] = "パスワードを変更しました"
			redirect_to user_path
	    else
	        flash[:notice] = "パスワードが正しく設定されていません"
	        redirect_to edit_password_path
	    end
	end

##  ユーザー  ##
	#ページング
	USER_PER = 20

	#def index
	#end

	#マイページ
	def show
		@user = User.find(current_user.id)
		@addresses = @user.addresses
		@range = @user.addresses.length
		@orders = @user.orders
		# @orders = Order.where(user_id: current_user.id) # 特定のユーザーに紐づくorders
		# @order_items = OrderItem.find(order_id:) # 特定のオーダーに紐づくitems
	end
	#マイページ編集
	def edit
		@user = User.find(current_user.id)
		@addresses = @user.addresses
		@addressnew = Address.new
	end
	#マイページ更新
	def update
		@user = User.find(current_user.id)
		if @user.update(user_params)
		   redirect_to user_path(@user.id)
		   flash[:notice] = "更新されました"
		else
		   redirect_to edit_user_path(@user.id)
		   flash[:alert] = "エラーが発生しました"
		end
	end


##  管理者  ##
	#ページング
	ADMIN_PER = 20
	#顧客一覧
	def admin_index
		@users = User.search(params[:search]).order(params[:sort]).order(id: :desc).page(params[:page]).per(ADMIN_PER)
		@navi = params[:sort]
		@total = User.where(deleted_at: nil).length
	end
	#顧客情報詳細
	def admin_show
		@user = User.find(params[:id])
		@addresses = @user.addresses
		@range = @user.addresses.length
		@orders = @user.orders
	end
	#顧客情報編集
	def admin_edit
		@user = User.find(params[:id])
		@addresses = @user.addresses
		@addressnew = Address.new
	end
	#顧客情報更新
	def admin_update
    	@user = User.find(params[:id])
		if @user.update(user_params)
		   redirect_to admin_show_user_path(@user.id)
		   flash[:notice] = "更新されました"
		else
		   redirect_to admin_show_user_path(@user.id)
		   flash[:alert] = "エラーが発生しました"
		end
	end


  	private

	def user_params
	params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number,
	                             :email, :password, :password_confirmation, :current_password, :greed_id, :customer_status, :payment_method,
	                             :default_address,
	                             addresses_attributes: [:id, :postal_code, :address, :user_id, :_destroy])
	end

	def ensure_correct_user
		if administrator_signed_in?
		elsif user_signed_in?
			@user = User.find_by(id: params[:id])
			if 	current_user.id != @user.id
				redirect_to user_path(current_user.id)
				flash[:notice] = "権限がありません"
			end
        else
        	redirect_to greeds_path
        	flash[:notice] = "権限がありません"
        end
    end
end
