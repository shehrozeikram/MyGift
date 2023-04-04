class AddContactNumberToStores < ActiveRecord::Migration[6.1]
  def change
    add_column :stores, :contact_number, :string
  end
end
