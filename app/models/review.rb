class Review < ActiveRecord::Base
	belongs_to :movie
	belongs_to :user
	belongs_to :admin
	belongs_to :movie
	validates :rating, presence: true
	# validates :user_id, presence: true
	validates :movie_id, presence: true
	alias_attribute :userId, :user_id
	alias_attribute :mid, :movie_id

	def rating_enum
  		[1,2,3,4,5]
	end

end
