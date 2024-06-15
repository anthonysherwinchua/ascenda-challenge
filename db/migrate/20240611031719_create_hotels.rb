class CreateHotels < ActiveRecord::Migration[7.1]
  def change
    create_table :hotels do |t|
      t.string :hotel_id, null: false
      t.integer :destination_id, null: false
      t.string :name
      t.text :description
      t.datetime :scraped_at
      t.timestamps
    end

    add_index :hotels, [:hotel_id, :destination_id], unique: true
  end
end
