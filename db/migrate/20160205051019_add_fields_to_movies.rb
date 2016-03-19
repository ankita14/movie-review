class AddFieldsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :music_director, :string
    add_column :movies, :producer, :string
    add_column :movies, :star_cast, :string
  end
end
