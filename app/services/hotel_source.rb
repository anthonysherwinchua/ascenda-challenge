# frozen_string_literal: true

class HotelSource
  ORM_MAPPING = {
    acme: Orm::Acme,
    paperflies: Orm::Paperflies,
    patagonia: Orm::Patagonia
  }.freeze

  attr_reader :supplier, :errors, :job_id, :main_id

  def initialze(supplier_id, job_id, main_id)
    @job_id = job_id
    @main_id = main_id
    @supplier = Supplier.find_by(id: supplier_id)
    Rails.logger.info "[#{@main_id}] Supplier: #{@supplier&.name}"
  end

  def data
    unless supplier.update(scrape_job_id: job_id, scrape_status: :started)
      @errors = "[#{@main_id}] ERROR: #{supplier.errors.full_messages}"
      return false
    end

    JSON.parse(response.body).map do |hash|
      orm.new(hash)
    end
  rescue StandardError => e
    Rails.logger.error("[#{@main_id}] Invalid response: #{e.message}")

    { error: 'failed to parse response' }
  end

  private

  def orm
    return @orm if @orm

    @orm = ORM_MAPPING[supplier.name.to_sym]

    if @orm.blank?
      @errors = "[#{@main_id}] ORM not found for #{supplier&.name}"
      nil
    else
      @orm
    end
  end

  def response
    @response ||= HTTParty.get(supplier.url)
  end
end
