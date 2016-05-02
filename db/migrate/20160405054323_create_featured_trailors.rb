class CreateFeaturedTrailors < ActiveRecord::Migration
  def change
    create_table :featured_trailors do |t|
      t.integer :movie_id
      t.integer :position

      t.timestamps null: false
    end
  end
end
