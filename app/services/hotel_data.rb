class HotelData
  attr_reader :supplier

  def initialize(supplier_id)
    @supplier = Supplier.find(supplier_id)
  end

  def call

  end

  private

  def response
    @response ||= HTTParty.get(supplier.url)
  end

  def data
    @data ||= JSON.parse(response.body)
  rescue => e
    Rails.logger.error("Invalid response: #{e.message}")

    { error: "failed to parse response" }
  end
end