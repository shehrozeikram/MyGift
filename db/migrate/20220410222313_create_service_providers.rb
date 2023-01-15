class CreateServiceProviders < ActiveRecord::Migration[6.1]
  def change
    create_table :service_providers do |t|
      t.belongs_to :user
      t.timestamps
    end
  end
end
