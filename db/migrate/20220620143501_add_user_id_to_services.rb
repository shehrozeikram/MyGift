class AddUserIdToServices < ActiveRecord::Migration[6.1]
  def change
    add_column :services, :user_id, :integer
  end
end
