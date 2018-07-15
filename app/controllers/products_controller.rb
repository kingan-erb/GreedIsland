class ProductsController < ApplicationController
  def index
    @greed = Greed.find(params[:greed_id])
    @products = @greed.products
  end

  def show
    @product = Product.find(params[:id])
    @musics = Music.where(product_id: @product.id).order(disk_number: :asc).order(music_number: :asc)
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

  def new
    @music = Music.new
    @musics = Music.where(product_id: 0).order(disk_number: :asc)
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      @musics = Music.where(product_id: 0).update_all(:product_id => @product.id)
      redirect_to product_path(@product.id)
    elsif
      @music = Music.new(music_params)
      @music.save
      redirect_to new_product_path
    else
      redirect_to new_product_path
    end
  end

  def edit
    @music = Music.new
    @product = Product.find(params[:id])
    @musics = Music.where(product_id: @product.id).order(disk_number: :asc).order(music_number: :asc)
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to edit_product_path(@product.id)
  end

  def destroy
  end

  private

  def product_params
      params.require(:product).permit(:artist_name,:product_name,:product_image_name,:price,:label_name,:genre_name,
      :inventry_status,:greed_id)
  end
  def music_params
    params.require(:music).permit(:music_name,:music_number,:disk_number)
  end


end
