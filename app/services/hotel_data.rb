class HotelData
  attr_reader :supplier

  def initialize(supplier_id)
    @supplier = Supplier.find(supplier_id)
  end

  def call; end
end