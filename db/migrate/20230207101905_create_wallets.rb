class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.float :balance

      t.timestamps
    end
  end
end
