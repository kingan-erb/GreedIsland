class CartItemsController < ApplicationController
before_action :ensure_correct_user, except: [:show, :index, :create,:update, :destroy]
##  ユーザー  ##
  #カートに追加
  def create
    if user_signed_in?
      added_product = Product.find(params[:product_id])
      exiting_item = current_user.cart_items.find_by(product_id: added_product.id)

      #ifがすごいのでなんとかしたい

      if exiting_item.nil?
      #カート内に今追加した商品がない場合
        # CartItem.transaction do
          @cart_item = CartItem.new(quantity_params)
          @cart_item.product_id = added_product.id
          @cart_item.user_id = current_user.id
          if @cart_item.save
            redirect_to cart_items_path
          else
            flash[:notice] = '処理に失敗しました。'
            redirect_to product_path(added_product.id)
          end
          # added_product.inventry_status -= @cart_item.quantity #決済時の反映に変更予定
          # # added_product.sales_quantity += @cart_item.quantity
          # added_product.save!
        # end
        #   redirect_to edit_cart_items_path
        # rescue => e
        #   flash[:notice] = '処理に失敗しました。'
        #   redirect_to product_path(added_product.id)
      else
      #すでに同じ商品がカートに追加されていた場合
        added_item = CartItem.new(quantity_params)
        exiting_item.quantity += added_item.quantity
        #在庫オーバーと10個以上購入するかどうかチェック
        if exiting_item.quantity > exiting_item.product.inventry_status
          exiting_item.quantity = exiting_item.product.inventry_status
          if exiting_item.save
            flash[:notice] = '在庫切れです。これ以上追加できません。'
            redirect_to cart_items_path
          else
            flash[:notice] = '処理に失敗しました。'
            redirect_to product_path(added_product.id)
          end
        elsif exiting_item.quantity > 10
          exiting_item.quantity = 10
          if exiting_item.save
            flash[:notice] = '購入上限です。これ以上追加できません。'
            redirect_to cart_items_path
          else
            flash[:notice] = '処理に失敗しました。'
            redirect_to product_path(added_product.id)
          end
        else
          if exiting_item.save
            redirect_to cart_items_path
          else
            flash[:notice] = '処理に失敗しました。'
            redirect_to product_path(added_product.id)
          end
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  #
  def show
  	# @user = User.find(params[:id]) #一旦コメントアウト。ルーティングにも追加の必要あり。
    # @cart_items = @user.cart_items
    @cart_items = current_user.cart_items
  end
  #カート内表示
  def index
    @cart_items = current_user.cart_items #Userログインまでコメントアウト
    #在庫数を超えた数量がカートに入っていないかチェック(ビュー側でこの処理をしてjavascriptで書き換えられたら理想？)
    @cart_items.each do |cart_item|
      if cart_item.quantity > cart_item.product.inventry_status
        cart_item.quantity = cart_item.product.inventry_status
        if cart_item.save #ここが抜けてた
          flash[:quantity_notice] = "カート内の数量が変更されました"
        end
      end
    end
  end



  # def edit
  # 	@cart_items = current_user.cart_items #Userログインまでコメントアウト
  # end
  #カート内商品数量変更
  def update
  	@cart_item = CartItem.find(params[:id])
    last_quantity = @cart_item.quantity

    if @cart_item.update!(quantity_params)
      # modified_quantity = last_quantity - @cart_item.quantity
      redirect_to cart_items_path
    else
      flash[:notice] = '処理に失敗しました。'
      redirect_to cart_items_path
    end
  end
  #カート内商品削除
  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.destroy
     redirect_to cart_items_path
    else
      flash[:notice] = '処理に失敗しました。'
      redirect_to product_path(added_product.id)
    end
  end


  private

  def quantity_params
    params.require(:cart_item).permit(:quantity)
  end

  def ensure_correct_user
    if administrator_signed_in?
    elsif user_signed_in?
      @user = User.find_by(id: params[:id])
      if  current_user.id != @user.id
        redirect_to user_path(current_user.id)
        flash[:notice] = "権限がありません"
      end
    else
          redirect_to greeds_path
          flash[:notice] = "権限がありません"
    end
  end
end
