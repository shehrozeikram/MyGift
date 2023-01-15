class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.string :title
      t.string :description
      t.string :distance
      t.float :ratings
      t.text :attachments
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
