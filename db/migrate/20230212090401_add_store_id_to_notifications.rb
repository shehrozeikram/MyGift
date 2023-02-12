class AddStoreIdToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :store_id, :integer
  end
end
