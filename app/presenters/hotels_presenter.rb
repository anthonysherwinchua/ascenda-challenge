class HotelsPresenter
  attr_reader :hotels, :params

  def initialize(params = {})
    @hotels = Hotel.includes(:location, :amenities)
    @params = params
  end

  def call
    hotels = hotels.where("name ILIKE ?", search_term) if search_term
    hotels = hotels.where("hotel_id = ?", hotel_id) if hotel_id
    hotels = hotels.where("destination_id = ?", destination_id) if destination_id
    hotels = hotels.page(page).per(per)

    hotels.map do |hotel|
      HotelDecorator.new(hotel)
    end
  end

  private

  def search_term
    @search_term ||= "%#{params[:search]}%"
  end

  def hotel_id
    @hotel_id ||= params[:id]
  end

  def destination_id
    @destination_id ||= params[:destination_id]
  end

  def page
    params[:page].to_i > 0 ? params[:page].to_i : 1
  end

  def per
    params[:per].to_i > 0 ? params[:per].to_i : 5
  end
end