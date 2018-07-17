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
    @address.destroy
    redirect_to admin_user_index_path
    flash[:notice] = "削除されました"
  end

  protected

  def address_params
    params.require(:address).permit(:postal_code, :address)
  end
end
