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
  end

  def edit
  end

  def update
  end

  def destroy
  end


end
