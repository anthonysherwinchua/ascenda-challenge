module Matchers
  class Hotel
    include Matchers::Common

    attr_reader :hotel, :new_attributes

    def initialize(hotel, new_attributes)
      @hotel = hotel
      @new_attributes = new_attributes
    end

    def attributes
      {
        name: name,
        description: description,
        images: images,
        booking_conditions: booking_conditions
      }
    end

    private

    def name
      longest_string([
        hotel.name,
        new_attributes[:name]
      ])
    end

    def description
      longest_string([
        hotel.description,
        new_attributes[:description]
      ])
    end

    def images
      combine_hashes(
        hotel.images,
        new_attributes[:images]
      )
    end

    def booking_conditions
      combine_array(
        hotel.booking_conditions,
        new_attributes[:booking_conditions]
      )
    end
  end
end