class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?


  	protected

  	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    		user_params.permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number, 
                                 :email, :password, :password_confirmation, :current_password, :greed_id, :customer_status, :payment_method,
                                 addresses_attributes: [:id, :postal_code, :address])
        end
  	end

	def after_sign_in_path_for(resource)
		case resource
		when User
    	products_path(@user.greed_id)
  	when Administrator
   		admin_products_path
  	end
	end

	def after_sign_out_path_for(resource)
    if resource == :user
      new_user_session_path
    else
      new_administrator_session_path
    end
  end

end
