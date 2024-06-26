# frozen_string_literal: true

json.array! @hotels do |hotel|
  json.extract! hotel, :id, :destination_id, :name, :location, :description, :amenities, :images, :booking_conditions
end
