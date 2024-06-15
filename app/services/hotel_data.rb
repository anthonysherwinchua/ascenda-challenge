class HotelData
  attr_reader :supplier

  ORM_MAPPING = {
    acme: Orm::Acme,
    paperflies: Orm::Paperflies,
    patagonia: Orm::Patagonia
  }.freeze

  def initialize(supplier_id)
    @supplier = Supplier.find_by(id: supplier_id)
  end

  def call
    return "ORM not found for #{supplier&.name}" unless orm

    data.each do |attributes|
      save(attributes)
    end
  end

  def save(attributes)
    orm_instance = orm.new(attributes)

    ActiveRecord::Base.transaction do
      hotel = Hotel.find_or_initialize_by(orm_instance.main_attributes)

      location_attributes = Matchers::Location.new(hotel.location, orm_instance.location_attributes).attributes
      if hotel.location
        hotel.location.update!(location_attributes)
      else
        hotel.location = Location.create!(location_attributes)
      end

      new_hotel_attributes = Matchers::Hotel.new(hotel, orm_instance.attributes).attributes.merge(
        scraped_at: Time.current
      )

      hotel.update!(new_hotel_attributes)

      orm_instance.amenities_attributes.each do |key, values|
        values.each do |value|
          # TODO: Need another job to merge amenity with the same name but with different category and update this relationship
          hotel.amenities << Amenity.find_or_create_by(category: key, name: value)
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error(e.message)
    end
  end

  private

  def orm
    @orm ||= ORM_MAPPING[supplier.name.to_sym]
  end

  def response
    @response ||= HTTParty.get(supplier.url)
  end

  def data
    @data ||= JSON.parse(response.body)
  rescue => e
    Rails.logger.error("Invalid response: #{e.message}")

    { error: "failed to parse response" }
  end
end