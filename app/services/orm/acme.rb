# frozen_string_literal: true

module Orm
  class Acme < Base
    def hotel_id
      original_attributes['Id']
    end

    def destination_id
      original_attributes['DestinationId']
    end

    def name
      original_attributes['Name']
    end

    def description
      original_attributes['Description']
    end

    def images; end

    def booking_conditions; end

    def latitude
      original_attributes['Latitude']
    end

    def longitude
      original_attributes['Longitude']
    end

    def address
      original_attributes['Address']
    end

    def city
      original_attributes['City']
    end

    def country
      original_attributes['Country']
    end

    def zipcode
      original_attributes['PostalCode']
    end

    def amenities
      {
        general: original_attributes['Facilities'] || []
      }
    end

    def delete?
      false
    end
  end
end
