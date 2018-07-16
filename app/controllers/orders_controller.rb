class OrdersController < ApplicationController
  
  def new
    @order = Order.new
    @cart_items = current_user.cart_items
  end


  def create
    @user = current_user.id
    if  @user.save
        redirect_to thanks_path
    else
    end
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def edit
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    # created_atを分解する処理
  end

  def update
  end

  def thanks
  end
end
