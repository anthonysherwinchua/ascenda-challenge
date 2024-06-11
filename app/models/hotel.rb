class Hotel < ApplicationRecord
  belongs_to :location

  validates :hotel_id, :destination_id, :name, presence: true
  validates :hotel_id, uniqueness: { scope: :destination_id }
end
