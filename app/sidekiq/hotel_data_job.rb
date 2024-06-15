class HotelDataJob
  include Sidekiq::Job

  def perform(supplier_id)
    HotelData.new(supplier_id).call(self.jid)
  end
end
