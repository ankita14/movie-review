class User < ActiveRecord::Base
  ratyrate_rater
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]
	
	attr_accessor :login         

  has_many :reviews

  validates :email, presence: true
	validates :password, presence: true
	validates :password_confirmation, presence: true
	validates :username, presence: true, length: {maximum: 255}, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]*\z/, message: "may only contain letters and numbers." }

	# def login=(login)
 #    @login = login
 #  end

 #  def login
 #    @login || self.username || self.email
 #  end

 def self.find_first_by_auth_conditions(warden_conditions)
 	conditions = warden_conditions.dup
  if login = conditions.delete(:login)
    where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
  else
    where(conditions).first
  end
 end

end
