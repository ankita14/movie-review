class Admin < ActiveRecord::Base
	ratyrate_rater
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  attr_accessor :login

  has_many :movies
  has_many :reviews
  has_many :critics_ratings
  
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true
	validates :password, presence: true
	validates :password_confirmation, presence: true
  validates :username, presence: true, length: {maximum: 255}, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]*\z/, message: "may only contain letters and numbers." }  

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions).first
    end
  end

end
