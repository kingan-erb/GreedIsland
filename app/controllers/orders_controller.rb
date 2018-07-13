class OrdersController < ApplicationController
  def create
    @user = current_user.id
    if  @user.save
        redirect_to thanks_path
    else
    end
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def thanks
  end
end
