class Hotel < ApplicationRecord
  belongs_to :location
  has_and_belongs_to_many :amenities

  validates :hotel_id, :destination_id, :name, presence: true
  validates :hotel_id, uniqueness: { scope: :destination_id }
end
