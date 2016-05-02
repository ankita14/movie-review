class AddAppToUsers < ActiveRecord::Migration
  def change
    add_column :users, :app, :string
  end
end
