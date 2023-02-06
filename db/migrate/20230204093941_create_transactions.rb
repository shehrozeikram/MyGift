class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :title
      t.date :send_date
      t.float :amount
      t.integer :user_id

      t.timestamps
    end
  end
end
