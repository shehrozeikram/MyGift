class AddAttachmentsToAds < ActiveRecord::Migration[6.1]
  def change
    add_column :ads, :attachments, :text
  end
end
