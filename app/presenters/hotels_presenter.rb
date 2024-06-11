class HotelsPresenter
  attr_reader :hotels

  def initialize(params = {})
    @hotels = Hotel.all
  end

  def call
    hotels.map do |hotel|
      HotelDecorator.new(hotel)
    end
  end
end