namespace :db do
  desc "Update ratings in movies table."
  task :update_ratings => :environment do
  	ActiveRecord::Base.connection
    Movie.all.each do |movie|
    	cr_count = movie.critics_ratings.count
    	ratings = 0
    	if cr_count > 0
	    	movie.critics_ratings.each do |cr|
	    		ratings = ratings + cr.rating
	    	end
	    	average_cr_ratings = ratings / cr_count
	    	movie.update_attributes(:rating => average_cr_ratings )
	    end
    end
  end
end