class LocationDecorator < SimpleDelegator
  def address
    [
      super,
      zipcode
    ].join(', ')
  end

  def as_json(options = {})
    super.merge(
      lat: latitude,
      lng: longitude
    )
  end
end