class MovieType < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, :use => [:slugged, :finders]
	has_many :movies
end
