class CreateFeaturedLatests < ActiveRecord::Migration
  def change
    create_table :featured_latests do |t|
      t.integer :movie_id
      t.integer :position

      t.timestamps null: false
    end
  end
end
