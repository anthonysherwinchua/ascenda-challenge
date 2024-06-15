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
        new_attributes[:latitude],
        location&.latitude
      )
    end

    def longitude
      more_detailed_float(
        new_attributes[:longitude],
        location&.longitude
      )
    end

    def address
      longest_string([
                       new_attributes[:address],
                       location&.address
                     ])
    end

    def city
      longest_string([
                       new_attributes[:city],
                       location&.city
                     ])
    end

    def country
      longest_string([
                       new_attributes[:country],
                       location&.country
                     ])
    end

    def zipcode
      longest_string([
                       new_attributes[:zipcode],
                       location&.zipcode
                     ])
    end
  end
end
