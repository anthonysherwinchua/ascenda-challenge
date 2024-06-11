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
        description: description
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
  end
end