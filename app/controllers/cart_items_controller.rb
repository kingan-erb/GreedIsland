class CartItemsController < ApplicationController

  def create
    if user_signed_in?
      added_product = Product.find(params[:product_id])
      exiting_product = current_user.cart_items.find_by(product_id: added_product.id)

      if exiting_product.nil?
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
        exiting_product.quantity += added_item.quantity
        if exiting_product.save
          redirect_to cart_items_path
        else
          flash[:notice] = '処理に失敗しました。'
          redirect_to product_path(added_product.id)
        end
      end
    else
      redirect_to new_user_session_path
    end
  end


  def show
  	# @user = User.find(params[:id]) #一旦コメントアウト。ルーティングにも追加の必要あり。
    # @cart_items = @user.cart_items
    @cart_items = current_user.cart_items
  end

  def index
    @cart_items = current_user.cart_items #Userログインまでコメントアウト
    #在庫数を超えた数量がカートに入っていないかチェック(ビュー側でこの処理をしてjavascriptで書き換えられたら理想？)
    @cart_items.each do |cart_item|
      if cart_item.quantity > cart_item.product.inventry_status
        cart_item.quantity = cart_item.product.inventry_status
        @quantity_change_flag = true
      end
    end
  end



  # def edit
  # 	@cart_items = current_user.cart_items #Userログインまでコメントアウト
  # end

  def update
  	@cart_item = CartItem.find(params[:id])
    last_quantity = @cart_item.quantity

    CartItem.transaction do
      @cart_item.update!(quantity_params)
      modified_quantity = last_quantity - @cart_item.quantity
      @cart_item.product.inventry_status += modified_quantity #決済時の反映に変更予定
      @cart_item.product.update!
    end
      redirect_to cart_items_path
    rescue => e
      flash[:notice] = '処理に失敗しました。'
      redirect_to cart_items_path
  end

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

end
