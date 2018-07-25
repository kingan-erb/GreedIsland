class OrdersController < ApplicationController
before_action :authenticate_administrator!, only: [:index, :admin_show, :edit, :admin_update]

##  ユーザー  ##
  USER_PER = 20
  #注文確認
  def new
    @order = Order.new
    @cart_items = current_user.cart_items
   #お届け先住所取得
    @address_array = []
    @postal_array = []
    current_user.addresses.each do |address|
      @address_array << address.address
      @postal_array << address.postal_code
    end
    #ラジオボタン選択用
    @default_button_num = current_user.default_address - 1
    #合計金額0だったら購入させない（url直打ちやthanksページからのブラウザバック対策）
    subtotal = 0
    @sum = 0
    @cart_items.each do |cart_item|
      #在庫数を超えた数量がカートに入っていないかチェック(ビュー側でこの処理をしてjavascriptで書き換えられたら理想？)
      if cart_item.quantity > cart_item.product.inventry_status
        cart_item.quantity = cart_item.product.inventry_status
        if cart_item.save
          flash[:quantity_notice] = "カート内の数量が変更されました"
        end
      end
      subtotal = cart_item.product.price * cart_item.quantity
      @sum += subtotal
    end
  end

  #注文確定
  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id

    Order.transaction do
      require "date"
      @order.delivery_status = 1
      @order.order_datetime = DateTime.now
      #希望配達日は3日後以降しか選択させない前提（未実装）。無理そうならこっちで条件分岐
      if @order.delivery_date.nil?
        @order.delivery_date = Date.today + 3
      end
      #郵便番号登録（ビューの変更に影響されるので変更できたらしたい &　関数化できる？）
      address_array = []
      postal_array = []
      current_user.addresses.each do |address|
        address_array << address.address
        postal_array << address.postal_code
      end
      case @order.delivery_address
        when address_array[0]
          @order.postal_code = postal_array[0]
        when address_array[1]
          @order.postal_code = postal_array[1]
        when address_array[2]
          @order.postal_code = postal_array[2]
        else
          #仮にこう記述
          # user_default_address = Address.find_by(: current_user.default_address)
          # @order.delivery_address = user_default_address.address
          # @order.postal_code = user_default_address.postal_code
          flash[:notice] = 'お届け先住所を選択してください'
          redirect_to new_order_path
          return
      end
      @order.save!
      #order_itemsテーブルに保存開始
      @cart_items = CartItem.where(user_id: @order.user_id)
      total_price = 0 #orderテーブル保存用
      @cart_items.each do |cart_item|
        unless cart_item.quantity == 0 then
          #order_itemsテーブルに保存開始
          product = cart_item.product

          order_item = OrderItem.new
          order_item.order_id = @order.id
          order_item.o_artist_name = product.artist_name
          order_item.o_product_name = product.product_name
          order_item.o_product_image_name_id = product.product_image_name_id
          order_item.o_price = product.price
          order_item.o_greed_id = product.greed.id
          order_item.o_quantity = cart_item.quantity
          order_item.product_id = product.id
          order_item.save!
          #在庫・売り上げ
          # binding.pry
          product.inventry_status -= cart_item.quantity
          product.sales_quantity += cart_item.quantity
          product.save!
          #orderのtotal_price用
          total_price += product.price * cart_item.quantity
          cart_item.destroy!
        end
      end
      @order.total_price = total_price
      @order.save!
      # @cart_items.destroy_all! #処理に失敗した + 数量0をカートに残すため使わない
    end
      redirect_to thanks_order_path(@order.id)
    rescue => e
      flash[:notice] = "処理に失敗しました"
      redirect_to new_order_path
  end
  #Thanksページ
  def thanks
    @order = Order.find(params[:id])
  end
  #注文詳細
  def show
    @order = Order.find(params[:id])
    @user = User.find(@order.user_id)
    @order_items = OrderItem.where(order_id: @order.id)
  end

##  管理者  ##
  ADMIN_PER = 20
  #注文一覧
  def admin_index
    @navi = params[:sort]
    @status = params[:status]
    if @status.present?
      @orders = Order.where(delivery_status: @status).order(params[:sort]).order(id: :desc).page(params[:page]).per(ADMIN_PER)
    else
      @orders = Order.order(params[:sort]).order(id: :desc).page(params[:page]).per(ADMIN_PER)
    end
    @total = Order.all.length
  end
  #注文詳細
  def admin_show
    @order = Order.find(params[:id])
    @user = User.find(@order.user_id)
    @order_items = @order.order_items
  end
  #ステータス更新
  def admin_update
    @order = Order.find(params[:id])
    @order.update(order_params)
    flash[:notice] = "配達状況を変更しました"
    redirect_to admin_show_order_path
    end
  #
  def update
  end

  private
    def order_params
      params.require(:order).permit(:payment_method,:delivery_address,:delivery_date,:delivery_time, :delivery_status, :user_id)
    end
end
