module Orm
  class Base
    attr_reader :original_attributes

    def initialize(original_attributes)
      @original_attributes = original_attributes
    end

    def main_attributes
      {
        hotel_id: sanitize(hotel_id),
        destination_id: destination_id
      }
    end

    def attributes
      {
        name: sanitize(name),
        description: sanitize(description)
      }
    end

    def location_attributes
      {
        latitude: latitude,
        longitude: longitude,
        address: sanitize(address),
        city: sanitize(city),
        country: sanitize(country),
        zipcode: sanitize(zipcode)
      }
    end

    def hotel_id
      raise NotImplementedError, "Subclass must implement the `hotel_id` method"
    end

    def destination_id
      raise NotImplementedError, "Subclass must implement the `destination_id` method"
    end

    def name
      raise NotImplementedError, "Subclass must implement the `name` method"
    end

    def description
      raise NotImplementedError, "Subclass must implement the `description` method"
    end

    def latitude
      raise NotImplementedError, "Subclass must implement the `latitude` method"
    end

    def longitude
      raise NotImplementedError, "Subclass must implement the `longitude` method"
    end

    def address
      raise NotImplementedError, "Subclass must implement the `address` method"
    end

    def city
      raise NotImplementedError, "Subclass must implement the `city` method"
    end

    def country
      raise NotImplementedError, "Subclass must implement the `country` method"
    end

    def zipcode
      raise NotImplementedError, "Subclass must implement the `zipcode` method"
    end

    private

    def sanitize(value)
      return value unless value.is_a?(String)

      value.strip.chomp(',')
    end

    def geocoded_address
    end
  end
end