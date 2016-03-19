class AddMovieTypeIdToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :movie_type_id, :integer
  end
end
