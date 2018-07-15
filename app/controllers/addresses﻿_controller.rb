class Addresses﻿Controller < ApplicationController

  def new
  	@address = Address.new
  end

  def create
  	@address = Address.new(address_params)
  end

  def destroy
  end

  protected

  def address_params
    params.require(:addresses).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number, 
                                  :email, :password, :greed_id, :customer_status, :payment_method, 
                                  addresses_attributes: [:id, :postal_code, :address])
  end
end
