class ChangeStarcastFormatInMovies < ActiveRecord::Migration
  def change
  	change_column :movies, :star_cast, :text
  end
end
