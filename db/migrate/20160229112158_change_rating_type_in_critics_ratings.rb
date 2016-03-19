class ChangeRatingTypeInCriticsRatings < ActiveRecord::Migration
  def change
  	change_column :critics_ratings, :rating, :float
  end
end
