class RenameType < ActiveRecord::Migration
  def change
  	rename_column :banners, :type, :ad_type
  end
end
