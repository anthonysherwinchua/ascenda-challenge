module Orm
  class Patagonia < Base
    include Orm::Parsers::Zipcode

    def hotel_id
      original_attributes["id"]
    end

    def destination_id
      original_attributes["destination"]
    end

    def name
      original_attributes["name"]
    end

    def description
      original_attributes["info"]
    end

    def images
      original_attributes["images"]&.transform_values! do |values|
        values.map do |value|
          {
            link: value["url"],
            description: value["description"]
          }
        end
      end
    end

    def booking_conditions; end

    def latitude
      original_attributes["lat"]
    end

    def longitude
      original_attributes["lng"]
    end

    def address
      tmp = original_attributes["address"]
      tmp.gsub(zipcode, '') if tmp && zipcode
      tmp
    end

    def city; end

    def country; end

    def zipcode
      zipcode_from(original_attributes["address"])
    end

    def amenities
      {
        uncategorized: original_attributes["amenities"] || []
      }
    end
  end
end