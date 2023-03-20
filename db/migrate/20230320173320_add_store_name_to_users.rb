class AddStoreNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :store_name, :string
  end
end
