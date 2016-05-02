# require Rails.root.join('lib', 'devise', 'encryptors', 'md5')
class User < ActiveRecord::Base
	TEMP_EMAIL_PREFIX = 'change@me'
	TEMP_EMAIL_REGEX = /\Achange@me/

  alias_attribute :name, :username

	ratyrate_rater
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable, :omniauthable,:encryptable, :encryptor => :md5, :authentication_keys => [:login]

	validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def valid_password?(password)
    return false if encrypted_password.blank?
    Devise.secure_compare(Devise::Encryptable::Encryptors::Md5.digest(password, nil, nil, nil), self.encrypted_password)
  end

  def password_salt
    'no salt'
  end

  def password_salt=(new_salt)
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          username: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
         # user.skip_confirmation! if user.respond_to?(:skip_confirmation)
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
	
	attr_accessor :login         

	has_many :reviews

	validates :email, presence: true
	validates :password, presence: true
	# validates :password_confirmation, presence: true
	# validates :username, presence: true, length: {maximum: 255}, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]*\z/, message: "may only contain letters and numbers." }
# validates :username, presence: true, length: {maximum: 255}, uniqueness: { case_sensitive: false } 
	# def login=(login)
 #    @login = login
 #  end

 #  def login
 #    @login || self.username || self.email
 #  end

 def self.find_first_by_auth_conditions(warden_conditions)
	conditions = warden_conditions.dup
	if login = conditions.delete(:login)
		where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login.downcase }]).first
	else
		conditions.permit! if conditions.class.to_s == "ActionController::Parameters"
    where(conditions).first
	end
 end

# bf0f5e72b797f804a45b27b58297ce09
# 25138f6433a4914e749e66cc84b3cc5f
 # def self.find_first_by_auth_conditions(warden_conditions)
 #    conditions = warden_conditions.dup
 #    if login = conditions.delete(:login)
 #      where(conditions).where(["lower(inn) = :value OR lower(email) = :value", { :value => login.downcase }]).first
 #    else
 #      conditions.permit! if conditions.class.to_s == "ActionController::Parameters"
 #      where(conditions).first
 #    end
 #  end

end
