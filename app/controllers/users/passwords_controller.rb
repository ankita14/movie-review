class Users::PasswordsController < Devise::PasswordsController
	# GET /resource/password/new
	# def new
	#   super
	# end

	# POST /resource/password
	# def create
 #    self.resource = resource_class.send_confirmation_instructions(resource_params.permit(:email))
 #    yield resource if block_given?

	#     if successfully_sent?(resource)
	#       respond_with({}, location: after_resending_confirmation_instructions_path_for(resource_name))
	#     else
	#       respond_with(resource)
	#     end
 #  	end
  # end
	# def create
	# 	self.resource = resource_class.send_reset_password_instructions(resource_params.permit!)
	# 	yield resource if block_given?

	# 	if successfully_sent?(resource)
	# 		respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
	# 	else
	# 		respond_with(resource)
	# 	end
	# end
	# def create
	#   super
	# end

	# GET /resource/password/edit?reset_password_token=abcdef
	# def edit
	#   super
	# end

	# PUT /resource/password
	# def update
	#   super
	# end

	# protected

	# def after_resetting_password_path_for(resource)
	#   super(resource)
	# end

	# The path used after sending reset password instructions
	# def after_sending_reset_password_instructions_path_for(resource_name)
	#   super(resource_name)
	# end
end
