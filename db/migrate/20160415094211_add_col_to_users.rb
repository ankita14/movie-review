class AddColToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mobile, :string
    add_column :users, :regID, :string
  end
end
