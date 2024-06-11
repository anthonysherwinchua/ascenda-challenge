class Location < ApplicationRecord
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :address, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :zipcode, presence: true
end
