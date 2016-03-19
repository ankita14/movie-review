class AddOrderToBanners < ActiveRecord::Migration
  def change
    add_column :banners, :order, :integer
  end
end
