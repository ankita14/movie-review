class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :f_name
      t.string :l_name
      t.string :email
      t.text :message

      t.timestamps null: false
    end
  end
end
