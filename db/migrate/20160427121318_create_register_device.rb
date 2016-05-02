class CreateRegisterDevice < ActiveRecord::Migration
  def change
    create_table :register_devices do |t|
      t.string :register
    end
  end
end
