class CreateWithdraws < ActiveRecord::Migration[6.1]
  def change
    create_table :withdraws do |t|
      t.string :card_holder_name
      t.string :iban_number
      t.string :billing_address
      t.string :cvc
      t.date :expire_date
      t.float :total_payment

      t.timestamps
    end
  end
end
