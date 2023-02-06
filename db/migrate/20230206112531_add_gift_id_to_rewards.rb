class AddGiftIdToRewards < ActiveRecord::Migration[6.1]
  def change
    add_column :rewards, :gift_id, :integer
  end
end
