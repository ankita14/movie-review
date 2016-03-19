class AddSlugToMovieTypes < ActiveRecord::Migration
  def change
    add_column :movie_types, :slug, :string
  end
end
