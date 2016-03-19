class Review < ActiveRecord::Base
	belongs_to :movie
	belongs_to :user
	belongs_to :admin
	belongs_to :movie
	validates :rating, presence: true
	validates :comment, presence: true
	# validates :user_id, presence: true
	# validates :movie_id, presence: true

	def rating_enum
  		[1,2,3,4,5]
	end

end
