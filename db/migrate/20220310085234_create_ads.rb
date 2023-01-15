class CreateAds < ActiveRecord::Migration[6.1]
  def change
    create_table :ads do |t|
      t.string :ad_title
      t.string :ad_type
      t.integer :category_id
      t.integer :product_id

      t.timestamps
    end
  end
end
