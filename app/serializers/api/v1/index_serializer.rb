class Api::V1::IndexSerializer < ActiveModel::Serializer
	attributes :id, :name, :genres, :language, :releasestatus, :thumbnail, :rating, :casting, :release_date#, :success

	def language
		if (object.language.present?) 
			if object.language.title == "Bollywood"
				object.language.title = "Hindi"
			else
				object.language.title
			end

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

	def thumbnail
		# if object.thumbnail.present?
			if object.thumbnail.file.exists?
				object.thumbnail = "https://viva-movie-review.herokuapp.com#{object.thumbnail.url}"
			else
				object.thumbnail = "https://viva-movie-review.herokuapp.com/assets/not_available.jpg"
			end
		# end
		
	end

end