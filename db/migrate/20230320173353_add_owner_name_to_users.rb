class AddOwnerNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :owner_name, :string
  end
end
