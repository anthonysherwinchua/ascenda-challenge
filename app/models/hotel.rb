class Hotel < ApplicationRecord
  validates :hotel_id, :destination_id, :name, presence: true
  validates :hotel_id, uniqueness: { scope: :destination_id }
end
