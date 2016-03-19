class AddFieldsToBanner < ActiveRecord::Migration
  def change
    add_column :banners, :type, :string
    add_column :banners, :size, :string
    add_column :banners, :google_add_js, :text
  end
end
