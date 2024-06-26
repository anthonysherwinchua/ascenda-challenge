# frozen_string_literal: true

class HotelDataJob
  include Sidekiq::Job

  def perform(supplier_id, main_id)
    Rails.logger.info "[#{main_id}] HotelData for #{suppleir_id}: Job ID: #{jid}"
    hotel_data = HotelData.new(supplier_id, main_id)
    return if hotel_data.call(jid)

    Rails.logger.error "[#{main_id}] #{hotel_data.errors}"
  end
end
