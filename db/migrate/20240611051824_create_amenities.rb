# frozen_string_literal: true

class CreateAmenities < ActiveRecord::Migration[7.1]
  def change
    create_table :amenities do |t|
      t.string :name, null: false
      t.string :category, null: false

      t.timestamps
    end

    add_index :amenities, %i[name category], unique: true
  end
end
