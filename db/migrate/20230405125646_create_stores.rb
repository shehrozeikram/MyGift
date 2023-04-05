class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :owner_name
      t.string :store_name
      t.string :balance
      t.integer :user_id
      t.text :attachments

      t.timestamps
    end
  end
end
