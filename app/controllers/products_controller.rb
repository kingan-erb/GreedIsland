class ProductsController < ApplicationController
  def index
    greed = Greed.find(params[:id])
    @products = greed.products
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

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def product_params
    params.require(:product).permit(:artist_name,:product_name,:product_image_name_id,:price,:label_name,:genre_name,
      :inventry_status,:sales_quantity,:greed_id, musics_attributes:[:id,:music_name,:music_number,:disk_number])
  end


end
