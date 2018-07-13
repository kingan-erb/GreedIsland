class ProductsController < ApplicationController
  def index
    greed = Greed.find(params[:id])
    @products = greed.products
  end

  def show
    @product = Product.find(params[:id])
    @musics = Music.where(product_id: @product.id)
  end

  def new
    @music = Music.new
    @musics = Music.where(product_id: 0)
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
  end

  def update
  end

  def destroy
  end

  private

  def product_params
    params.require(:product).permit(:artist_name,:product_name,:product_image_name,:price,:label_name,:genre_name,
      :inventry_status,:sales_quantity,:greed_id)
  end
  def music_params
    params.require(:music).permit(:music_name,:music_number,:disk_number)
  end


end
