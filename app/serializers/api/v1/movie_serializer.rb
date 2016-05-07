class Api::V1::MovieSerializer < ActiveModel::Serializer
	
	attributes :name, :genres, :description, :movie_reviews, :thumbnail,
	:movieRat, :releasestatus, :director, :producer, :stars, :music_director, 
	:id, :movieReviewed, :review
	
	# has_many :critics_ratings

	def description
		object.description
	end

	def review
		if object.critics_ratings.count > 0
			object.critics_ratings.collect { |cr| {:name => cr.title, :rating => cr.rating}}
		else
			[{
				:name => "",
				:rating => 0			
			}]
		end
	end

	def movieRat
		if object.reviews.count > 0
			rev_array = object.reviews.map { |review| [review.rating] }
			array = rev_array.sum
			total_sum = array.inject(0, :+)
			total_count = object.reviews.count
			avg_ratings = total_sum/total_count
		else
			0
		end
	end

	def releasestatus
		if object.release_date.future?
			'no'
		else
			'yes'
		end
	end

	def genres
		if object.genres.present?
			genrearray = object.genres.map { |genre| genre.title }
			genrearray.join(',')
		end
	end

	def language
		if (object.language.present?) 
			if object.language.title == "Bollywood"
				object.language.title = "Hindi"
			else
				object.language.title
			end

		end
	end

	def thumbnail
			if object.thumbnail.file.exists?
				object.thumbnail = "https://viva-movie-review.herokuapp.com#{object.thumbnail.thumb.url}"
			else
				object.thumbnail = "https://viva-movie-review.herokuapp.com/assets/not_available.jpg"
			end		
	end

	def movieReviewed
		scope[:movieReviewed]
	end

end
