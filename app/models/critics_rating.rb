class CriticsRating < ActiveRecord::Base
	belongs_to :admin
	belongs_to :movie
	validates :movie, presence: true
	# validates :title, presence: true
	# validates :rating, presence: true
	# validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

	def title_enum
		['Bollywood Hungama', 'Imdb.com', 'Rediff.com', 'Gulf News', 'Hindustan Times', 'koimoi.com', 'Desimartini.com']
	end

end
