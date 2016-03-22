class Movie < ActiveRecord::Base
	ratyrate_rateable 'rating'
	extend FriendlyId
	# attr_accessible :title, :rating, :reviews

	scope :in_last_six_months, -> {
		where(:release_date => 6.months.ago..Date.today)
	}

	before_save :default_values
  def default_values
  	if rating.blank?
    	self.rating = 0.0
    end
  end
	
	friendly_id :title, :use => [:slugged, :finders]
	mount_uploader :image, ImageUploader
	belongs_to :admin
	has_and_belongs_to_many :genres
	belongs_to :movie_type
	has_many :reviews
	has_many :critics_ratings
	validates :title, presence: true
	validates :release_date, presence: true
	# validates :movie_length, presence: true
	validates :director, presence: true
	# validates :image, presence: true
	# validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_blank: true }

	def self.search(search)
	  where("title ILIKE ?", "%#{search}%") 
	  # where("content LIKE ?", "%#{search}%")
	end

	# ratyrate_rateable 'visual_effects'
	# attr_accessible :genre_ids

	# accepts_nested_attributes_for :genres, :allow_destroy => true
	#   # attr_accessible :genres_attributes

 #  rails_admin do
 #    configure :genres do
 #      inverse_of :movies
 #      # configuration here
 #    end
 #  end

	# def rating_enum
 #  	[1,2,3,4,5]
	# end
end
