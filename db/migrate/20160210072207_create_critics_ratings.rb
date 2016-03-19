class CreateCriticsRatings < ActiveRecord::Migration
  def change
    create_table :critics_ratings do |t|
      t.string :title
      t.integer :rating
      t.integer :admin_id
      t.integer :movie_id

      t.timestamps null: false
    end
  end
end
