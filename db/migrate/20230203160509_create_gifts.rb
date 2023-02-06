class CreateGifts < ActiveRecord::Migration[6.1]
  def change
    create_table :gifts do |t|
      t.string :sender_name
      t.string :your_message
      t.string :receiver_name
      t.string :receiver_phone_number
      t.text :attachments

      t.timestamps
    end
  end
end
