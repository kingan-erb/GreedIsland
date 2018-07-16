class ProductsController < ApplicationController

  def user_index
    @greed = Greed.find(params[:id])
    @products = @greed.products
    @search_form_flag = true #ヘッダー分岐
  end

  def user_search
    @products = Product.search(params[:search])
    @search_form_flag = true
  end

  def user_show
    @product = Product.find(params[:id])
    @musics = Music.where(product_id: @product.id)
    @cart_item = CartItem.new
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


  def index
    if params[:cid]
      @greed = Greed.find(params[:cid])
      @products = @greed.products.order(params[:sort]).order(id: :desc)
    else
      @products = Product.order(params[:sort]).order(id: :desc)
    end
  end

  def show
    @product = Product.find(params[:id])
    @musics = Music.where(product_id: @product.id).order(disk_number: :asc).order(music_number: :asc)
  end

  def new
    @product = Product.new
    @product.musics.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save
       redirect_to product_path(@product.id)
    else
       flash[:alert] = "エラーが発生しました"
       redirect_to new_product_path
    end
  end

  def edit
    @music =Music.new
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
       redirect_to edit_product_path(@product.id)
       flash[:notice] = "更新されました"
    else
       redirect_to edit_product_path(@product.id)
       flash[:alert] = "エラーが発生しました"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to administrators_path
    flash[:notice] = "削除されました"
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
