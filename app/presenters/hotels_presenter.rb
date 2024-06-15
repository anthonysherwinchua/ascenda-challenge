# frozen_string_literal: true

class HotelsPresenter
  attr_reader :hotels, :params

  def initialize(params = {})
    @params = params
  end

  def call
    # NOTE: currently using Memory Store
    # alternatives: Redis, Memcache, FileStore, or Database Store
    Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
      @hotels = Hotel.includes(:location, :amenities)
      @hotels = filter(@hotels)
      @hotels = @hotels.order(name: :asc).page(page).per(per)

      @hotels.map do |hotel|
        HotelDecorator.new(hotel)
      end
    end
  end

  private

  def filter(hotels)
    hotels = hotels.where('name ILIKE ?', search_term) if search_term
    hotels = hotels.where('hotel_id in (?)', hotel_ids) if hotel_ids
    hotels = hotels.where('destination_id = ?', destination_id) if destination_id
    hotels
  end

  def cache_key
    json_string = JSON.generate(params)
    Digest::SHA256.hexdigest(json_string)
  end

  def search_term
    @search_term ||= "%#{params[:search]}%"
  end

  def hotel_ids
    @hotel_ids ||= params[:hotels].presence
  end

  def destination_id
    @destination_id ||= begin
      Integer(params[:destination])
    rescue StandardError
      nil
    end
  end

  def page
    params[:page].to_i.positive? ? params[:page].to_i : 1
  end

  def per
    params[:per].to_i.positive? ? params[:per].to_i : 5
  end
end
