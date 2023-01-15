class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :order_detail
      t.string :comment
      t.string :delivery_address
      t.string :coupon

      t.timestamps
    end
  end
end
