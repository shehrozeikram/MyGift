class AddReceiverIdToRewards < ActiveRecord::Migration[6.1]
  def change
    add_column :rewards, :receiver_id, :integer
  end
end
