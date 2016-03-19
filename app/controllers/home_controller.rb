class HomeController < ApplicationController
	before_filter :set_admin

	def set_admin
		@top_movies = Movie.in_last_six_months

		@upcoming = Movie.where('release_date > ?', Date.today).order(:release_date)
							 .paginate(:per_page => 10, :page => params[:page])

		@latest = Movie.where(:release_date => 6.months.ago..Date.today).order(release_date: :desc)
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
			@search_results = false
			@movies = Movie.all.order(release_date: :desc).paginate(:page => params[:page],:per_page => 10 )
		end

		# @movies = Movie.all.order(release_date: :desc).paginate(:page => params[:page],:per_page => 10 )
		@index_top_banner = Banner.where(:position => 'Index Top').order(:order)
		@index_bottom_banner = Banner.where(:position => 'Index Bottom').order(:order)
	end

	def movie_detail
		@movie = Movie.friendly.find(params[:id])
		@detail_top_banner = Banner.where(:position => 'Movie Detail Top').order(:order)
		@detail_bottom_banner = Banner.where(:position => 'Movie Detail Bottom').order(:order)
	end

	def movie_genres
		@movie_genres = Genre.friendly.find(params[:id])
		@genre_top_banner = Banner.where(:position => 'Genre Top').order(:order)
		@genre_bottom_banner = Banner.where(:position => 'Genre Bottom').order(:order)
	end

	def movie_types
		@type_movies = MovieType.friendly.find(params[:id])
		@type_top_banner = Banner.where(:position => 'Type Top').order(:order)
		@type_bottom_banner = Banner.where(:position => 'Type Bottom').order(:order)
	end

	def top_rated
		@top_movies.each do |movie|
			@average_cr_rating = 0.0
			if movie.critics_ratings.count > 0
				critics_count = movie.critics_ratings.count
				cr_rating = 0
				movie.critics_ratings.each do |cr|
					cr_rating = cr_rating + cr.rating
				end
				@average_cr_rating = cr_rating/critics_count	
				movie.update_attributes(:rating => @average_cr_rating)
			end
		end

		@top_rated_movies = Movie.in_last_six_months.order(rating: :desc)
		@top_rated_top_banner = Banner.where(:position => 'Top Rated Top').order(:order)
		@top_rated_bottom_banner = Banner.where(:position => 'Top Rated Bottom').order(:order)
	end

	def upcoming
		@upcoming_top_banner = Banner.where(:position => 'Upcoming Top').order(:order)
		@upcoming_bottom_banner = Banner.where(:position => 'Upcoming Bottom').order(:order)
	end

	def latest
		@latest_top_banner = Banner.where(:position => 'Latest Top').order(:order)
		@latest_bottom_banner = Banner.where(:position => 'Latest Bottom').order(:order)
	end

	def about
		@page_top_banner = Banner.where(:position => 'Page Top').order(:order)
		@page_bottom_banner = Banner.where(:position => 'Page Bottom').order(:order)    
	end
	
end
