class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?


  	protected

  	def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :postcal_code,
    													   :address, :phone_number, :payment_method, :greed_id])
  	end

	def after_sign_in_path_for(resource)
	  	case resource
	  	when User
	  		greeds_path
	  	when Administrator
	  		greeds_path
	  	end
	end

	def after_sign_out_path_for(resource)
	  	case resource
	  	when User
	  		new_user_session_path
	  	when Administrator
	  		new_administrator_session_path
	  	end
	end

end
