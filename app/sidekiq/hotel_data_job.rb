# frozen_string_literal: true

class HotelDataJob
  include Sidekiq::Job

  def perform(supplier_id)
    HotelData.new(supplier_id).call(jid)
  end
end
