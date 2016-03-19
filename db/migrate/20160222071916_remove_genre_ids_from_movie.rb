class RemoveGenreIdsFromMovie < ActiveRecord::Migration
  def change
  	remove_column :movies, :genre_ids, :integer
  end
end
