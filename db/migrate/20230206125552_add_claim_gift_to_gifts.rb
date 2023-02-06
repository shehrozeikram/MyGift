class AddClaimGiftToGifts < ActiveRecord::Migration[6.1]
  def change
    add_column :gifts, :claim_gift, :boolean, default: false
  end
end
