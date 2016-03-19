class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :banner
      t.string :link
      t.string :text
      t.string :position

      t.timestamps null: false
    end
  end
end
