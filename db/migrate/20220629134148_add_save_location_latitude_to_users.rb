class AddSaveLocationLatitudeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :save_location_latitude, :float
  end
end
