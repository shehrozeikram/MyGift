class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :body
      t.float :amount

      t.timestamps
    end
  end
end
