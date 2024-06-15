class SupplierDataJob
  include Sidekiq::Job

  def perform(supplier_names = [])
    supplier_ids_from(supplier_names).map do |supplier_id|
      HotelDataJob.perform_async(supplier_id)
    end
  end

  private

  def supplier_ids_from(supplier_names)
    supplier_ids = Supplier.where(name: supplier_names).pluck(:id)
    supplier_ids = Supplier.pluck(:id) if supplier_ids.blank?
    supplier_ids
  end
end
