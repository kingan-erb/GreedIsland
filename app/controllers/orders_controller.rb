class OrdersController < ApplicationController
  
  def new
    @order = Order.new
    @cart_items = current_user.cart_items
    #在庫数を超えた数量がカートに入っていないかチェック(ビュー側でこの処理をしてjavascriptで書き換えられたら理想？)
    @cart_items.each do |cart_item|
      if cart_item.quantity > cart_item.product.inventry_status
        cart_item.quantity = cart_item.product.inventry_status
        flash[:quantity_notice] = "カート内の数量が変更されました"
      end
    end
  end


  def create
    @order = Order.new(order_params)

    Order.transaction do
      require "date"
      @order.user_id = current_user.id
      @order.order_datetime = DateTime.now
      @order.delivery_status = 1
      #希望配達日は3日後以降しか選択させない前提。無理そうならこっちで条件分岐
      if @order.delivery_date.nil?
        @order.delivery_date = Date.today + 3
      end
        # @order.delivery_status = '配送準備中'
      @order.save!
      #order_itemsテーブルに保存開始
      @cart_items = CartItem.where(user_id: @order.user_id)
      @cart_items.each do |cart_item|
        product = cart_item.product
        # もっといい書き方ありそう
        order_item = OrderItem.new
        order_item.order_id = @order.id
        order_item.o_artist_name = product.artist_name
        order_item.o_product_name = product.product_name
        order_item.o_product_image_name = product.product_image_name
        order_item.o_price = product.price
        order_item.o_greed_id = product.greed.id
        order_item.o_quantity = cart_item.quantity
        order_item.product_id = product.id
        #在庫・売り上げ
        product.inventry_status -= cart_item.quantity
        product.sales_quantity += cart_item.quantity
        product.save!
      end
      @cart_items.save!
      @cart_items.destroy_all!
    end
      redirect_to thanks_order_path(@order.id)
    rescue => e
      flash[:notice] = "処理に失敗しました"
      redirect_to new_order_path
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
    @order = Order.find(params[:id])
  end

  private
    def order_params
      params.require(:order).permit(:payment_method,:delivery_address,:delivery_date,:delivery_time)
    end

end
