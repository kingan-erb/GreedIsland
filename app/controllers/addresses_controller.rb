class AddressesController < ApplicationController
  def index
  end

  def create
    @user = User.find(params[:id])
    @address = Address.new(address_params)
    @address.user_id = @user.id
    @address.save
    redirect_to edit_admin_user_path(@user.id)
  end
  def edit
    @address = Address.find(params[:id])
  end
  def update
  end

  def destroy
    @address = Address.find(params[:id])
    @user = @address.user
    @address1 = Address.find_by(user_id: @user.id)
    if @user.default_address == 2 && @address.id == @address1.id
       @user.update(:default_address => @user.default_address - 1)
       @address.destroy
       redirect_to admin_user_path(@user.id)
       flash[:notice] = "削除されました"
    elsif
      @user.default_address == 3
      @user.update(:default_address => @user.default_address - 1)
      @address.destroy
      redirect_to admin_user_path(@user.id)
      flash[:notice] = "削除されました"
    else
      @address.destroy
      redirect_to admin_user_path(@user.id)
      flash[:notice] = "削除されました"
    end
  end

  protected

  def address_params
    params.require(:address).permit(:postal_code, :address, :user_id)
  end
end
