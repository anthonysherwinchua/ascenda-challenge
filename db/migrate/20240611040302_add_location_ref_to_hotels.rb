# frozen_string_literal: true

class AddLocationRefToHotels < ActiveRecord::Migration[7.1]
  def change
    add_reference :hotels, :location, null: false, foreign_key: true
  end
end
