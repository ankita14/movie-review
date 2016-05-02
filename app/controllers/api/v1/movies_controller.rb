class Api::V1::MoviesController < Api::V1::BaseController

  def check
	  if (params[:authkey] && params[:app_type])
	    if (params[:authkey] == 'dd1a9e9ced7dfb713db2e5fce7ba4989') && (params[:app_type] == 'native')      
	      return true
	    else
	      return api_error(status: 404, errors: 'Not found')
	    end
	  else
	    return api_error(status: 400, errors: 'Bad Request')
	  end
  end

	def moviedetails
		movies = Movie.where(:id => params[:id])

		@user_check_id = Review.find_by_user_id_and_movie_id(params[:user_id], params[:id])

		if @user_check_id.present?
			movie_reviewed = 1
		else
			movie_reviewed = 0
		end

		
		if movies.present?
			s_value = 1
		else
			s_value = 0
		end
		
		render(
				json: ActiveModel::ArraySerializer.new(
					movies,
					scope: {movieReviewed: movie_reviewed},
					success: s_value,
					meta_key: :success,
					each_serializer: Api::V1::MovieSerializer,
					root: 'movies',
				)
			)
	end

	def getTopRatedMovies
		if params[:type] == "Hindi"
			type_id = MovieType.where(:title => 'Bollywood').first.id
			top_rated_movies = Movie.where(:release_date => 3.months.ago..Date.today, :movie_type_id => type_id).order(rating: :desc).paginate(:per_page => 5, :page => params[:page])
			if top_rated_movies.present?
				s_value = 1
			else
				s_value = 0
			end
		elsif params[:type] == "Hollywood"
			type_id = MovieType.where(:title => 'Hollywood').first.id
			top_rated_movies = Movie.where(:release_date => 3.months.ago..Date.today, :movie_type_id => type_id).order(rating: :desc).paginate(:per_page => 5, :page => params[:page])
			if top_rated_movies.present?
				s_value = 1
			else
				s_value = 0
			end
		else
			type_id = MovieType.where(:title => 'Bollywood').first.id
			top_rated_movies = Movie.where(:release_date => 3.months.ago..Date.today, :movie_type_id => type_id).order(rating: :desc).paginate(:per_page => 5, :page => params[:page])
			if top_rated_movies.present?
				s_value = 1
			else
				s_value = 0
			end
		end
		render(
				json: ActiveModel::ArraySerializer.new(
					top_rated_movies,
					success: s_value,
					meta_key: :success,
					each_serializer: Api::V1::IndexSerializer,
					root: 'movies',
				)
			)    
	end

	def getLatestMovies
		if params[:type] == "Hindi"
			type_id = MovieType.where(:title => 'Bollywood').first.id
			latest_movies = Movie.where(:release_date => 3.months.ago..Date.today, :movie_type_id => type_id).order(release_date: :desc).paginate(:per_page => 5, :page => params[:page])
			if latest_movies.present?
				s_value = 1
			else
				s_value = 0
			end
		elsif params[:type] == "Hollywood"
			type_id = MovieType.where(:title => 'Hollywood').first.id
			latest_movies = Movie.where(:release_date => 3.months.ago..Date.today, :movie_type_id => type_id).order(release_date: :desc).paginate(:per_page => 5, :page => params[:page])
			if latest_movies.present?
				s_value = 1
			else
				s_value = 0
			end
		else
			type_id = MovieType.where(:title => 'Hindi').first.id
			latest_movies = Movie.where(:release_date => 3.months.ago..Date.today, :movie_type_id => type_id).order(release_date: :desc).paginate(:per_page => 5, :page => params[:page])
			if latest_movies.present?
				s_value = 1
			else
				s_value = 0
			end    
		end

		render(
				json: ActiveModel::ArraySerializer.new(
					latest_movies,
					success: s_value,
					meta_key: :success,
					each_serializer: Api::V1::IndexSerializer,
					root: 'movies',
				)
			)    

	end

	def getUpcomingMovies
		if params[:type] == "Hindi"
			type_id = MovieType.where(:title => 'Bollywood').first.id
			upcoming_movies = Movie.where('(release_date > ? AND movie_type_id= ?)', Date.today, type_id).order(:release_date).paginate(:per_page => 5, :page => params[:page])
			if upcoming_movies.present?
				s_value = 1
			else
				s_value = 0
			end 
		elsif params[:type] == "Hollywood"
			type_id = MovieType.where(:title => 'Hollywood').first.id
			upcoming_movies = Movie.where('(release_date > ? AND movie_type_id= ?)', Date.today, type_id).order(:release_date).paginate(:per_page => 5, :page => params[:page])
			if upcoming_movies.present?
				s_value = 1
			else
				s_value = 0
			end 
		else
			type_id = MovieType.where(:title => 'Bollywood').first.id
			upcoming_movies = Movie.where('(release_date > ? AND movie_type_id= ?)', Date.today, type_id).order(:release_date).paginate(:per_page => 5, :page => params[:page])
			if upcoming_movies.present?
				s_value = 1
			else
				s_value = 0
			end 
		end
		render(
				json: ActiveModel::ArraySerializer.new(
					upcoming_movies,
					success: s_value,
					meta_key: :success,
					each_serializer: Api::V1::IndexSerializer,
					root: 'movies',
				)
			)
	end

	def getMovies
		if (params[:searchCon].present? && params[:type].present?)
			if params[:type] == 'All'
				movies = Movie.search(params[:searchCon]).paginate(:per_page => 5, :page => params[:page])
				if movies.present?
					s_value = 1
				else
					s_value = 0
				end				
			end				
		elsif params[:type] == "Hindi"
			type_id = MovieType.where(:title => 'Bollywood').first.id
			movies = Movie.where(:release_date => 3.months.ago..Date.today, :movie_type_id => type_id).order(release_date: :desc).paginate(:per_page => 5, :page => params[:page])
			if movies.present?
				s_value = 1
			else
				s_value = 0
			end
		elsif params[:type] == "Hollywood"
			type_id = MovieType.where(:title => 'Hollywood').first.id
			movies = Movie.where(:release_date => 3.months.ago..Date.today, :movie_type_id => type_id).order(release_date: :desc).paginate(:per_page => 5, :page => params[:page])
			if movies.present?
				s_value = 1
				more = 1
			else
				s_value = 0
			end
		else
			type_id = MovieType.where(:title => 'Bollywood').first.id
			movies = Movie.where(:release_date => 3.months.ago..Date.today, :movie_type_id => type_id).order(release_date: :desc).paginate(:per_page => 5, :page => params[:page])
			if movies.present?
				s_value = 1
			else
				s_value = 0
			end
		end

		render(
			json: ActiveModel::ArraySerializer.new(
				movies,
				success: s_value,
				meta_key: :success,
				each_serializer: Api::V1::IndexSerializer,
				root: 'movies',
			)
		)
		
	end

	def terms
		render :json => { 
    :success => 1, 
    :terms => "Please read the terms and conditions before using this app, this app is operated by Vivacity Infotech Pvt. Ltd."
 	  }.to_json
	end

	def userSaveRating
		review  = Review.new(review_params)
		if review.save
			render :json => { 
      :success => 1, 
      :message => "Rating done successfully."
   	  }.to_json
   	else
   		render :json => { 
      :success => 0, 
      :message => "Oops! An error occurred."
   	  }.to_json
		end
	end

	private

	def review_params
		params.permit(:userId, :mid, :rating)
	end

end
