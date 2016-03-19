class AddMovieReviewsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :movie_reviews, :text
  end
end
