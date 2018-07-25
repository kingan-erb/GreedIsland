class ProductsController < ApplicationController
before_action :authenticate_administrator!, except: [:index, :search, :show]

##　ユーザー　##
  USER_PER = 12
  SEARCH_PER = 20
  #カテゴリー別商品一覧
  def index
    @greed = Greed.find(params[:id])
    @products = @greed.products.order(params[:sort]).order(sales_quantity: :desc).page(params[:page]).per(USER_PER)
    @navi = params[:sort]
    @search_form_flag = true #ヘッダー分岐
  end

  #商品名検索
  def search
    @products = Product.search(params[:search]).page(params[:page]).per(SEARCH_PER)
    @search_form_flag = true
    @cart_item = CartItem.new
  end

  #商品詳細
  def show
    @product = Product.find(params[:id])
    @musics = Music.where(product_id: @product.id).order(disk_number: :asc).order(music_number: :asc)
    @cart_item = CartItem.new
    # 曲順管理用、ディスク数とそれぞれの曲数を取得
    @max_disknum = @musics.maximum(:disk_number)
    @music_num_array = []
    for i in 1..@max_disknum do
      music_num = @musics.where(disk_number: i).count
      @music_num_array << music_num
    end
    #在庫数表示
    case @product.inventry_status
      when 0 then
         @inventry_symbol = '×'
         @no_inventry = true
      when 1..10 then
        @inventry_symbol = @product.inventry_status
      when 11..30 then
        @inventry_symbol = '△'
      else
        @inventry_symbol = '◯'
      end
    # 数量選択用
    @inventry_array = []
      @product.inventry_status.times do |q| #q=quantity
        if q < 10
          @inventry_array << [q + 1, q + 1]
        else
          break
        end
      end
  end


##  管理者  ##
  ADMIN_PER = 20
  #商品一覧
  def admin_index
    @products = Product.order(params[:sort]).order(id: :desc).page(params[:page]).per(ADMIN_PER)
    @navi = params[:sort]
  end
  #カテゴリー別商品一覧
  def admin_category
    @navi = params[:sort]
    @greed = Greed.find(params[:id])
    @products = @greed.products.order(params[:sort]).order(id: :desc).page(params[:page]).per(ADMIN_PER)
  end
  #商品詳細
  def admin_show
    @product = Product.find(params[:id])
    @musics = @product.musics.order(disk_number: :asc).order(music_number: :asc)
  end
  #商品作成ページ
  def admin_new
    @product = Product.new
    @product.musics.build
  end
  #商品作成
  def admin_create
    @product = Product.new(product_params)
    if @product.save
       redirect_to admin_show_product_path(@product.id)
    else
       flash[:alert] = "エラーが発生しました"
       redirect_to admin_new_product_path
    end
  end
  #商品編集
  def admin_edit
    @music =Music.new
    @product = Product.find(params[:id])
  end
  #商品更新
  def admin_update
    @product = Product.find(params[:id])
    if @product.update(product_params)
       redirect_to admin_edit_product_path(@product.id)
       flash[:notice] = "更新されました"
    else
       redirect_to admin_edit_product_path(@product.id)
       flash[:alert] = "エラーが発生しました"
    end
  end
  #商品削除
  def admin_destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to admin_products_path
      flash[:notice] = "削除されました"
    else
      redirect_to admin_show_product_path(@product.id)
      flash[:alert] = "エラーが発生しました"
    end
  end

  private
  def product_params
    params.require(:product).permit(
      :artist_name,:product_name,:product_image_name,:price,:label_name,:genre_name,
      :inventry_status,:sales_quantity,:greed_id,
      musics_attributes: [:id, :music_name,:music_number,:disk_number,:product_id, :_destroy]
    )
  end

end
