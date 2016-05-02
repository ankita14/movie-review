class FeaturedLatest < ActiveRecord::Base
	belongs_to :movie
	validates :position, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 3}
	validates :movie, presence: true
	
end
