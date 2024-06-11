module Matchers
  class Location
    include ::Matchers::Common

    attr_reader :location, :new_attributes

    def initialize(location, new_attributes)
      @location = location
      @new_attributes = new_attributes
    end

    def attributes
      {
        latitude: latitude,
        longitude: longitude,
        address: address,
        city: city,
        country: country,
        zipcode: zipcode
      }
    end

    private

    def latitude
      more_detailed_float(
        location&.latitude,
        new_attributes[:latitude]
      )
    end

    def longitude
      more_detailed_float(
        location&.longitude,
        new_attributes[:longitude]
      )
    end

    def address
      longest_string([
        location&.address,
        new_attributes[:address]
      ])
    end

    def city
      longest_string([
        location&.city,
        new_attributes[:city]
      ])
    end

    def country
      longest_string([
        location&.country,
        new_attributes[:country]
      ])
    end

    def zipcode
      longest_string([
        location&.zipcode,
        new_attributes[:zipcode]
      ])
    end
  end
end