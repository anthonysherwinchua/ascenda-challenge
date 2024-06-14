class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :city
      t.string :country
      t.string :zipcode

      t.timestamps
    end
  end
end
