class AddressesController < ApplicationController

##  共通  ##
  #住所追加
  def create
    @user = User.find(params[:id])
    @address = Address.new(address_params)
    @address.user_id = @user.id
    if @address.save
      if administrator_signed_in?
        redirect_to admin_edit_user_path(@user.id)
        flash[:notice] = "作成されました"
      else
        redirect_to edit_user_path(@user.id)
        flash[:notice] = "作成されました"
      end
    else
      redirect_to edit_user_path(@user.id)
      flash[:alert] = "エラーが発生しました"
    end
  end
  #住所削除
  def destroy
    @address = Address.find(params[:id])
    @user = @address.user
    @address1 = Address.find_by(user_id: @user.id)
    if (@user.default_address == 2 && @address.id == @address1.id) || @user.default_address == 3
      @user.update(:default_address => @user.default_address - 1)
      @address.destroy
      if administrator_signed_in?
        redirect_to admin_show_user_path(@user.id)
        flash[:notice] = "削除されました"
      else
        redirect_to user_path(@user.id)
        flash[:notice] = "削除されました"
      end
    elsif
      @address.destroy
      if administrator_signed_in?
        redirect_to admin_show_user_path(@user.id)
        flash[:notice] = "削除されました"
      else
        redirect_to user_path(@user.id)
        flash[:notice] = "削除されました"
      end
    else
      redirect_to greeds_path
      flash[:alert] = "エラーが発生しました"
    end
  end

  protected

  def address_params
    params.require(:address).permit(:postal_code, :address, :user_id)
  end
end
