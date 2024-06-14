class HotelDecorator < SimpleDelegator
  def id
    hotel_id
  end

  def name
    super.titleize
  end

  def location
    LocationDecorator.new(super).as_json(
      only: [
        :lat,
        :lng,
        :address,
        :city,
        :country
      ]
    )
  end

  def amenities
    super.group_by(&:category).except("uncategorized").transform_values { |amenities| amenities.map(&:name) }
  end
end
