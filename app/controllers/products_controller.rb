class ProductsController < ApplicationController
 
  def index
    # greed = Greed.find(params[:id])
    # @products = greed.products
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    # @musics = ソート？？
  end

  def new
    @product = Product.new
    @music = Music.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      # @music = Music.new
      # @music.product_id = @product.id
      # logger.debug(@music.product_id)
      redirect_to admin_new_music_path#ビューを分けてみる
    else
      redirect_to new_product_path
    end
  end

  # def music_new
  #   @music = Music.new
  #   @music.product_id = music_params[:product_id]
  #   logger.debug(@music.product_id)
  # end

  def music_create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def product_params
    params.require(:product).permit(:id,:artist_name,:product_name,:product_image_name,:price,:label_name,:genre_name,
      :inventry_status,:greed_id)
    # [:id,:music_name,:music_number,:disk_number]
  end

  def music_params
    params.require(:music).permit(:product_id)
  end

end
