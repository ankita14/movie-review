class Genre < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, :use => [:slugged, :finders]
	has_and_belongs_to_many :movies
	# has_many :movies
end
