class AddCardIdToGifts < ActiveRecord::Migration[6.1]
  def change
    add_column :gifts, :card_id, :integer
  end
end
