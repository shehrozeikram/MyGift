class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :title
      t.float :price
      t.text :attachments

      t.timestamps
    end
  end
end
