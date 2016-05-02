class RemoveAdminIdFromMovie < ActiveRecord::Migration
  def change
    remove_column :movies, :admin_id, :integer
  end
end
