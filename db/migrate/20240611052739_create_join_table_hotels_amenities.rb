# frozen_string_literal: true

class CreateJoinTableHotelsAmenities < ActiveRecord::Migration[7.1]
  def change
    create_join_table :hotels, :amenities do |t|
      t.index %i[hotel_id amenity_id]
      t.index %i[amenity_id hotel_id]
    end
  end
end
