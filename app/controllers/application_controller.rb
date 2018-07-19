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
	  	greeds_path
	end

	def after_sign_out_path_for(resource)
	  	new_user_session_path
	end

end
