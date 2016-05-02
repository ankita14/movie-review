class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery #with: :exception
	# before_filter :ensure_signup_complete, only: [:new, :create, :update, :destroy]
	# before_action :configure_permitted_parameters, if: :devise_controller?
	before_filter :configure_permitted_parameters, if: :devise_controller?
	after_filter :store_location

	def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'
    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

	def store_location
	  # store last url - this is needed for post-login redirect to whatever the user last visited.
	  return unless request.get? 
	  if (request.path != "/users/sign_in" &&
	      request.path != "/users/sign_up" &&
	      request.path != "/users/password/new" &&
	      request.path != "/users/password/edit" &&
	      request.path != "/users/confirmation" &&
	      request.path != "/users/sign_out" &&
	      !request.xhr?) # don't store ajax calls
	    session[:previous_url] = request.fullpath 
	  end
	end


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
				# session[:previous_url]+"?movie=review" || user_root_path
				session[:previous_url] || user_root_path		
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
