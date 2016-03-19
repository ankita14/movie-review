class CreateMovieTypes < ActiveRecord::Migration
  def change
    create_table :movie_types do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
