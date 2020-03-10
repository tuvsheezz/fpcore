class ApplicationController < ActionController::Base
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  protected
  def configure_devise_permitted_parameters
	registration_params = [:name, :phone2, :phone, :address, :email, :password, :password_confirmation, :branch_id, :cover]

	if params[:action] == 'update'
      devise_parameter_sanitizer.permit(:account_update) {
	    |u| u.permit(registration_params << :current_password)
	  }
	elsif params[:action] == 'create'
	  devise_parameter_sanitizer.permit(:sign_up) {
		|u| u.permit(registration_params)
	  }
	end
  end
  protect_from_forgery with: :exception
end
