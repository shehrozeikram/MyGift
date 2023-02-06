class CreateRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.string :title
      t.date :send_date
      t.float :amount
      t.integer :user_id

      t.timestamps
    end
  end
end
