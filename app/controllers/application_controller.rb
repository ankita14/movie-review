class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery #with: :exception
  # before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end 

  private

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      return user_root_path
    elsif resource_or_scope == :admin
      return new_admin_session_path
    end
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.is_a?(User)
        user_root_path
      elsif resource.is_a?(Admin)
        rails_admin.dashboard_path
      end
  end

  # Overwriting the sign_out redirect path method
  # def after_sign_out_path_for(resource_or_scope)
  #   unless current_admin
  #   	request.referrer
  #   end
  # end

  # def after_sign_out_path_for(resource_or_scope)
  # 	request.referrer
  # end

  # def after_sign_out_path_for(resource_or_scope)
    
  # end

  # def after_sign_out_path_for(user)
    
  # end

end
