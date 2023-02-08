class AddStoreIdToPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :store_id, :integer
  end
end
