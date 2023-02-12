class AddIsCompletedToWithdraws < ActiveRecord::Migration[6.1]
  def change
    add_column :withdraws, :is_completed, :boolean, default: false
  end
end
