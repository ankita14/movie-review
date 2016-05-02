class HomeController < ApplicationController
	before_filter :set_admin

	def set_admin
		@top_movies = Movie.where(:release_date => 3.months.ago..Date.today).order(rating: :desc)

		@upcoming = Movie.where('release_date > ?', Date.today).order(:release_date)
							 .paginate(:per_page => 12, :page => params[:page])

		# @latest = Movie.where(:release_date => 6.months.ago..Date.today).order(release_date: :desc).paginate(:page => params[:page],:per_page => 12 )
		@latest_bollywood = Movie.where(:release_date => 1.months.ago..Date.today, :movie_type_id => '6', :rating => 0.5..5).order(release_date: :desc).paginate(:page => params[:page],:per_page => 12 )
		@latest_hollywood = Movie.where(:release_date => 1.months.ago..Date.today, :movie_type_id => '2', :rating => 0.5..5).order(release_date: :desc).paginate(:page => params[:page],:per_page => 12 )
		@genres = Genre.all
		@movie_types = MovieType.all
		@banners = Banner.all
		@header_banner = Banner.where(:position => 'Header')
		@sidebar_banners = Banner.where(:position => 'Sidebar').order(:order)
	end

	def index

		@search_results = false
		if params[:search]
			@search_results = true
			@movies = Movie.search(params[:search]).order(release_date: :desc).paginate(:page => params[:page],:per_page => 10 )
		else
			@movies = Movie.all.order(release_date: :desc).paginate(:page => params[:page],:per_page => 10 )
		end

		if FeaturedTrailor.find_by_position(1).present?
			@featured_upcoming1 = FeaturedTrailor.find_by_position(1).movie
		end
		if FeaturedTrailor.find_by_position(2).present?
			@featured_upcoming2 = FeaturedTrailor.find_by_position(2).movie
		end
		if FeaturedTrailor.find_by_position(3).present?
			@featured_upcoming3 = FeaturedTrailor.find_by_position(3).movie
		end
		if FeaturedLatest.find_by_position(1).present?
			@featured_latest1 = FeaturedLatest.find_by_position(1).movie
		end
		if FeaturedLatest.find_by_position(2).present?
			@featured_latest2 = FeaturedLatest.find_by_position(2).movie
		end
		if FeaturedLatest.find_by_position(3).present?
			@featured_latest3 = FeaturedLatest.find_by_position(3).movie
		end
		@index_top_banner = Banner.where(:position => 'Index Top').order(:order)
		@index_bottom_banner = Banner.where(:position => 'Index Bottom').order(:order)
		@index_inbetween_banner = Banner.where(:position => 'Index In between').order(:order)
	end

	def movie_detail
		@movie = Movie.friendly.find(params[:id])
		@movie_reviews = @movie.reviews.where(:approved => true).paginate(:page => params[:page],:per_page => 10)
		# @user_movie_check = Review.find_by_user_id_and_movie_id(current_user.id,params[:movie_id])
		@detail_top_banner = Banner.where(:position => 'Movie Detail Top').order(:order)
		@detail_bottom_banner = Banner.where(:position => 'Movie Detail Bottom').order(:order)
	end

	def movie_genres
		@genre = Genre.friendly.find(params[:id])
		@genre_movies = @genre.movies.order(release_date: :desc).paginate(:page => params[:page],:per_page => 5)
		@genre_top_banner = Banner.where(:position => 'Genre Top').order(:order)
		@genre_bottom_banner = Banner.where(:position => 'Genre Bottom').order(:order)
	end

	def movie_types
		@type = MovieType.friendly.find(params[:id])
		@type_movies = @type.movies.paginate(:page => params[:page],:per_page => 5 )
		@type_top_banner = Banner.where(:position => 'Type Top').order(:order)
		@type_bottom_banner = Banner.where(:position => 'Type Bottom').order(:order)
	end

	def bollywood_top_rated
		if params[:search]
			@top_rated_movies = Movie.search(params[:search]).in_last_three_months.where(:movie_type_id => '6').order(rating: :desc).paginate(:page => params[:page],:per_page => 12 )
		else
			@top_rated_movies = Movie.in_last_three_months.where(:movie_type_id => '6').order(rating: :desc).paginate(:page => params[:page],:per_page => 12 )
		end
		@top_rated_top_banner = Banner.where(:position => 'Top Rated Top').order(:order)
		@top_rated_between_banner = Banner.where(:position => 'Top Rated In between').order(:order)
		@top_rated_bottom_banner = Banner.where(:position => 'Top Rated Bottom').order(:order)
	end

	def hollywood_top_rated
		if params[:search]
			@holly_top_rated_movies = Movie.search(params[:search]).in_last_three_months.where(:movie_type_id => '2').order(rating: :desc).paginate(:page => params[:page],:per_page => 12 )
		else
			@holly_top_rated_movies = Movie.in_last_three_months.order(rating: :desc).where(:movie_type_id => '2').paginate(:page => params[:page],:per_page => 12 )
		end
		@top_rated_top_banner = Banner.where(:position => 'Top Rated Top').order(:order)
		@top_rated_between_banner = Banner.where(:position => 'Top Rated In between').order(:order)
		@top_rated_bottom_banner = Banner.where(:position => 'Top Rated Bottom').order(:order)
	end

	def bollywood_upcoming
		if params[:search]
			@upcoming_movies = Movie.search(params[:search]).where('release_date > ?', Date.today).order(:release_date)
							 .paginate(:per_page => 12, :page => params[:page])
		else			
			@upcoming_movies = Movie.where('(release_date > ? AND movie_type_id= ?)', Date.today, 6).order(:release_date)
							 .paginate(:per_page => 12, :page => params[:page])
		end
		@upcoming_between_banner = Banner.where(:position => 'Upcoming In between').order(:order)
		@upcoming_top_banner = Banner.where(:position => 'Upcoming Top').order(:order)
		@upcoming_bottom_banner = Banner.where(:position => 'Upcoming Bottom').order(:order)
	end

	def hollywood_upcoming
		if params[:search]
			@holly_upcoming_movies = Movie.search(params[:search]).where('release_date > ?', Date.today).where(:movie_type_id => '2').order(:release_date)
							 .paginate(:per_page => 12, :page => params[:page])
		else
			@holly_upcoming_movies = Movie.where('release_date > ?', Date.today).where(:movie_type_id => '2').order(:release_date)
							 .paginate(:per_page => 12, :page => params[:page])
		end
		@upcoming_between_banner = Banner.where(:position => 'Upcoming In between').order(:order)
		@upcoming_top_banner = Banner.where(:position => 'Upcoming Top').order(:order)
		@upcoming_bottom_banner = Banner.where(:position => 'Upcoming Bottom').order(:order)
	end

	def bollywood_latest
		if params[:search]
			@latest = Movie.search(params[:search]).where(:release_date => 6.months.ago..Date.today, :movie_type_id => '6').order(release_date: :desc).paginate(:page => params[:page],:per_page => 12 )
		else
			@latest = Movie.where(:release_date => 6.months.ago..Date.today, :movie_type_id => '6').order(release_date: :desc).paginate(:page => params[:page],:per_page => 12 )
		end
		@latest_between_banner = Banner.where(:position => 'Latest In between').order(:order)
		@latest_top_banner = Banner.where(:position => 'Latest Top').order(:order)
		@latest_bottom_banner = Banner.where(:position => 'Latest Bottom').order(:order)
	end

	def hollywood_latest
		if params[:search]
			@holly_latest_movies = Movie.search(params[:search]).where(:release_date => 6.months.ago..Date.today, :movie_type_id => '2').order(release_date: :desc).paginate(:page => params[:page],:per_page => 12 )
		else
			@holly_latest_movies = Movie.where(:release_date => 6.months.ago..Date.today, :movie_type_id => '2').order(release_date: :desc).paginate(:page => params[:page],:per_page => 12 )
		end
		@latest_between_banner = Banner.where(:position => 'Latest In between').order(:order)
		@latest_top_banner = Banner.where(:position => 'Latest Top').order(:order)
		@latest_bottom_banner = Banner.where(:position => 'Latest Bottom').order(:order)
	end

	def about
		@page_top_banner = Banner.where(:position => 'Page Top').order(:order)
		@page_bottom_banner = Banner.where(:position => 'Page Bottom').order(:order)    
	end
	
end
