class AddReviewsToCriticsRatings < ActiveRecord::Migration
  def change
    add_column :critics_ratings, :reviews, :text
  end
end
