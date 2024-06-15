# frozen_string_literal: true

class HotelDataCleaner
  def self.call
    return if Supplier.started.exists?

    scrape_job_ids = Supplier.where(scrape_status: :completed).pluck(:scrape_job_id)

    Hotel.where.not(scrape_job_id: scrape_job_ids).or(
      Hotel.where(scrape_job_id: nil)
    ).find_each(&:destroy)
  end
end
