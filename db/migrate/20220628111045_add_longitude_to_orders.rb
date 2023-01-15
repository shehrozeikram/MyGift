class AddLongitudeToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :longitude, :float
  end
end
