class CartItemsController < ApplicationController
  def create
  end

  def show
  	@user = User.find(params[:id])
	@cart_items = @user.cart_items
  end

  def edit
  	@cart_items = current_user.cart_items
  end

  def destroy
  	@cart_items = current_user.cart_items
  	@cart_items.destroy
  	redirect_to cart_items_path
  end

  def update
  	@cart_item = CartItem.find(params[:id])
  	@cart_item.update
  end
end
