class CreateBusinesses < ActiveRecord::Migration[6.1]
  def change
    create_table :businesses do |t|
      t.string :title
      t.string :description
      t.float :distance
      t.float :ratings
      t.float :longitude
      t.float :latitude
      t.integer :user_id
      t.text :attachments

      t.timestamps
    end
  end
end
