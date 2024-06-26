# frozen_string_literal: true

class SupplierDataJob
  include Sidekiq::Job

  def perform(supplier_names = [])
    @main_id = SecureRandom.uuid

    supplier_ids_from(supplier_names).map do |supplier_id|
      HotelDataJob.perform_async(supplier_id, @main_id)
    end
  end

  private

  def supplier_ids_from(supplier_names)
    supplier_ids = Supplier.where(name: supplier_names).pluck(:id)
    supplier_ids = Supplier.pluck(:id) if supplier_ids.blank?
    Rails.logger.info "[#{@main_id}] Supplier IDs: #{supplier_ids}"
    supplier_ids
  end
end
