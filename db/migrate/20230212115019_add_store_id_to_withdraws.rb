class AddStoreIdToWithdraws < ActiveRecord::Migration[6.1]
  def change
    add_column :withdraws, :store_id, :integer
  end
end
