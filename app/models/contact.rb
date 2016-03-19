class Contact < ActiveRecord::Base
	validates :l_name, presence: true
	validates :f_name, presence: true
	validates :message, presence: true
	validates :email, presence: true
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end
