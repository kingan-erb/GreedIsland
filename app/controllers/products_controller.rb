class ProductsController < ApplicationController
  def index
    @greed = Greed.find(params[:id])
    @products = @greed.products
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
<<<<<<< HEAD
       flash[:alert] = "エラーが発生しました"
=======
>>>>>>> f_modified_product
       redirect_to new_product_path
    end
  end

  def edit
    @music =Music.new
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
<<<<<<< HEAD
    if @product.update(product_params)
       redirect_to edit_product_path(@product.id)
       flash[:notice] = "更新されました"
    else
       redirect_to edit_product_path(@product.id)
       flash[:alert] = "エラーが発生しました"
    end
=======
    @product.update(product_params)
    redirect_to edit_product_path(@product.id)
    flash[:notice] = "更新されました"
>>>>>>> f_modified_product
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
