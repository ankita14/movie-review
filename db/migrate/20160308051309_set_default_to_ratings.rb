class SetDefaultToRatings < ActiveRecord::Migration
  def change
    change_column :movies, :rating, :float, default: 0
  end
end
