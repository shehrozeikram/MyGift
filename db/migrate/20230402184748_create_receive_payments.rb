class CreateReceivePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :receive_payments do |t|
      t.float :amount
      t.integer :store_id
      t.string :date

      t.timestamps
    end
  end
end
