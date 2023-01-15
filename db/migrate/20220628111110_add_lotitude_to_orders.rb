class AddLotitudeToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :latitude, :float
  end
end
