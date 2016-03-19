class RenameColumnOfMovie < ActiveRecord::Migration
  def change
  	rename_column :movies, :genre_id, :genre_ids
  end
end
