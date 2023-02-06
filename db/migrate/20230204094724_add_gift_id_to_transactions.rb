class AddGiftIdToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :gift_id, :integer
  end
end
