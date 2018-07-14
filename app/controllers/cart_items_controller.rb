class CartItemsController < ApplicationController

  def create
    added_product = Product.find(params[:product_id])
    # added_product = Product.find(params[:product_id])

    CartItem.transaction do
      @cart_item = CartItem.new(quantity_params)
      @cart_item.product_id = added_product.id
      @cart_item.user_id = 1 #仮に
      # @cart_item.user_id = current_user.id
      @cart_item.save!
      added_product.inventry_status -= @cart_item.quantity
      added_product.sales_quantity += @cart_item.quantity
      added_product.save!
    end
      redirect_to edit_cart_items_path
    rescue => e
      flash[:notice] = '処理に失敗しました。'
      redirect_to product_path(added_product.id)
  end


  def show
  	# @user = User.find(params[:id]) #一旦コメントアウト。ルーティングにも追加の必要あり。
    # @cart_items = @user.cart_items
    @cart_items = CartItem.all #仮に
  end



  def edit
  	# @cart_items = current_user.cart_items #Userログインまでコメントアウト
    @cart_items = CartItem.all
  end

  def destroy
  	@cart_items = current_user.cart_items
  	@cart_items.destroy
  	redirect_to cart_items_path
  end

  def update
  	@cart_item = CartItem.find(params[:id])
  	@cart_item.update
    redirect_to cart_items_path(@cart_item)
  end


  private

  def quantity_params
    params.require(:cart_item).permit(:quantity)
  end
end
