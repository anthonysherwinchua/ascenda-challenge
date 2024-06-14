module Orm
  class Paperflies < Base
    include Orm::Parsers::Zipcode

    def hotel_id
      original_attributes["hotel_id"]
    end

    def destination_id
      original_attributes["destination_id"]
    end

    def name
      original_attributes["hotel_name"]
    end

    def description
      original_attributes["details"]
    end

    def images
      original_attributes["images"]&.transform_values! do |values|
        values.map do |value|
          {
            link: value["link"],
            description: value["caption"]
          }
        end
      end
    end

    def booking_conditions
      original_attributes["booking_conditions"]
    end

    def latitude; end

    def longitude; end

    def address
      tmp = original_attributes.dig("location", "address")

      tmp && zipcode ? tmp.gsub(zipcode, '') : tmp
    end

    def city; end

    def country
      original_attributes.dig("location", "country")
    end

    def zipcode
      zipcode_from(original_attributes.dig("location", "address"))
    end

    def amenities
      original_attributes["amenities"] || []
    end
  end
end