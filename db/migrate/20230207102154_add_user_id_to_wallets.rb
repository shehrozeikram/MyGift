class AddUserIdToWallets < ActiveRecord::Migration[6.1]
  def change
    add_column :wallets, :user_id, :integer
  end
end
