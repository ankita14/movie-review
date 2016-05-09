class Movie < ActiveRecord::Base
	alias_attribute :casting, :star_cast
	alias_attribute :stars, :star_cast
	alias_attribute :language, :movie_type
	alias_attribute :thumbnail, :image
	alias_attribute :plot, :description
	alias_attribute :name, :title
	
	ratyrate_rateable 'rating'
	extend FriendlyId
	# attr_accessible :title, :rating, :reviews

	scope :in_last_three_months, -> {
		where(:release_date => 3.months.ago..Date.today)
	}
	
	friendly_id :title, :use => [:slugged, :finders]
	mount_uploader :image, ImageUploader
	belongs_to :admin
	has_and_belongs_to_many :genres
	belongs_to :movie_type
	has_many :reviews, :dependent => :destroy, :inverse_of => :movie
	has_many :critics_ratings
	has_many :featured_trailors
	has_many :featured_latests
	validates :title, presence: true
	validates :release_date, presence: true
	validates :movie_type, presence: true
	validates :director, presence: true
	# validates :image, presence: true
	# validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_blank: true }

	def self.search(search)
	  where("title ILIKE ?", "%#{search}%")
	end

	# def movieReviewed
		
	# end

	# def success
	#   1
	# end

	# def attributes
	#   super.merge({'success' => 1})
	# end

end
