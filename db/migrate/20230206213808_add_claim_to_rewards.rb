class AddClaimToRewards < ActiveRecord::Migration[6.1]
  def change
    add_column :rewards, :claim, :boolean, default: false
  end
end
