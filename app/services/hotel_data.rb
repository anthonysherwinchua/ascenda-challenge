class HotelData
  attr_reader :supplier

  ORM_MAPPING = {
    acme: Orm::Acme,
    paperflies: Orm::Paperflies,
    patagonia: Orm::Patagonia
  }.freeze

  def initialize(supplier_id)
    @supplier = Supplier.find(supplier_id)
  end

  def call
    if orm
      data.each do |attributes|
        orm.new(attributes).save
      end
    else
      Rails.logger.info("ORM not found")
    end
  end

  private

  def orm
    @orm ||= ORM_MAPPING[supplier.name.to_sym]
  end

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