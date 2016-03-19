class AddAdminIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :admin_id, :integer
  end
end
