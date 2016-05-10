class Api::V1::UsersController < Api::V1::BaseController
	# skip_before_filter :verify_authenticity_token, :only => :create

	def saveRegID
		app = RailsPushNotifications::GCMApp.new
		app.gcm_key = 'AIzaSyDsMw3IYd_ocq_i3p9TPuRYlmrQa5-gLNI'
		app.save
		if app.save
      notif = app.notifications.build(
        destinations: [params[:regID]],
        data: { message: 'Welcome User, Thanks for installing our application. We will provide you lots of information about movies like release date, reviews, starcast etc.' }
      )
      if notif.save
        app.push_notifications
        notif.reload             
      end     
    end
		
		if (params[:regID].present?)
			regid = params[:regID]
			connection = ActiveRecord::Base.connection
			statement = "INSERT INTO register_devices(register) VALUES('#{regid}')";
			if connection.execute(statement)
				render :json => { 
		      :success => 1, 
		      :message => "Device registration ID added successfully"
		   	  }.to_json
			else
				render :json => { 
		      :success => 0, 
		      :message => "Oops! An error occurred."
		   	  }.to_json
			end
		end
	end

	def login
		if (params[:emailaddress].present? && params[:passwd].present? )
			user = User.find_by_email(params[:emailaddress])
			if user.present?
				valid_user = user.valid_password?(params[:passwd])
				if valid_user
					render :json => { 
					:userID => user.id,
		      :success => 1, 
		      :message => "Login successfully."
		   	  }.to_json
				else
					render :json => { 
		      :success => 0, 
		      :message => "Password is not correct."
		   	  }.to_json
				end
			else
				render :json => { 
	      :success => 0, 
	      :message => "No such email found."
	   	  }.to_json		
			end
		else
			render :json => { 
      :success => 0, 
      :message => "Email or Password can not be blank!"
   	  }.to_json
		end
	end

	def register
		user = User.new(user_params)
		if params[:mobile].present?
			user.mobile = params[:mobile]
		end
		if params[:regID].present?
			user.regID = params[:regID]
		end
    if user.save
    	render :json => { 
      :success => 1, 
      :message => "User registered successfully.",
   	  }.to_json
      return
    else
      render :json => { 
      :success => 2, 
      :message => "Email Address already exists.",
   	  }.to_json
    end
		
	end

	def forgetpass
		@user = User.find_by_email(params[:email])
		if @user.present?
			@user.send_reset_password_instructions
			render :json => { 
	      :success => 1, 
	      :message => "An email containing password reset link is send to your email."
	   	}.to_json

		else
		  render :json => { 
	      :success => 0, 
	      :message => "Unable to find email id."
   	  }.to_json
		end
	end

	private

		def user_params
			params.permit(:name, :email, :password,)
		end

end