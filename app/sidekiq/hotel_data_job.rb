class HotelDataJob
  include Sidekiq::Job

  def perform(supplier_id)
    HotelData.new(supplier_id).call
  end
end
