class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.string :address, null: false
      t.string :city
      t.string :country, null: false
      t.string :zipcode, null: false

      t.timestamps
    end
  end
end
