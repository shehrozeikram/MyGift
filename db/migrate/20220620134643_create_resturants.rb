class CreateResturants < ActiveRecord::Migration[6.1]
  def change
    create_table :resturants do |t|
      t.string :title
      t.float :distance
      t.float :ratings
      t.text :attachments
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
