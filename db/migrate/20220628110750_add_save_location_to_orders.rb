class AddSaveLocationToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :save_locations, :boolean
  end
end
