class AddUserIdToResturants < ActiveRecord::Migration[6.1]
  def change
    add_column :resturants, :user_id, :integer
  end
end
