class LocationDecorator < SimpleDelegator
  def address
    [
      super,
      zipcode
    ].join(', ')
  end

  def as_json(options = {})
    super.merge({
      address: address,
      lat: latitude,
      lng: longitude
    }.stringify_keys)
  end
end
