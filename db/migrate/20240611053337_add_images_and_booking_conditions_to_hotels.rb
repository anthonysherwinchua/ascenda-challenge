# frozen_string_literal: true

class AddImagesAndBookingConditionsToHotels < ActiveRecord::Migration[7.1]
  def change
    add_column :hotels, :images, :json, default: {}
    add_column :hotels, :booking_conditions, :string, array: true, default: []
  end
end
