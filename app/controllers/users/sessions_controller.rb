class Users::SessionsController < Devise::SessionsController
	# before_filter :configure_sign_in_params, only: [:create]

	# def create
	# 	puts "ccccc"
	# 	puts params
	# 	puts "ccccc"
	# 	recover_old_password unless user_signed_in?

	# 	resource = warden.authenticate! auth_options
	# 	set_flash_message(:notice, :signed_in) if is_navigational_format?
	# 	sign_in resource_name, resource

	# 	respond_with resource, :location => after_sign_in_path_for(resource)
	# end

	# def recover_old_password

	#  	email = params[:user]['email']
	# 	# pass  = Digest::MD5.hexdigest(params[:user]['password'],nil,nil,nil)
	# 	pass  = Digest::MD5.hexdigest params[:user]['password']
	# 	@user = User.find_by_email_and_encrypted_password(email, pass)

	# 	if @user.blank?

	# 		resource = warden.authenticate! auth_options
	# 		respond_with resource, :location => after_sign_in_path_for(resource)

	# 	elsif

	# 		puts "111111"
	# 		puts @user
	# 		puts "111111"

	# 		# if !@user.encrypted_password.nil?
	# 		#   @user.encrypted_password = BCrypt::Password.create params[:user]['password']
	# 		#   @user.save
	# 		#   create
	# 		# end  

	# 	end
	# end

	# GET /resource/sign_in
	# def new
	#   super
	# end

	# POST /resource/sign_in
	# def create
	#   super
	# end

	# DELETE /resource/sign_out
	# def destroy
	#   super
	# end

	# protected

	# If you have extra params to permit, append them to the sanitizer.
	# def configure_sign_in_params
	#   devise_parameter_sanitizer.for(:sign_in) << :username
	# end
end
