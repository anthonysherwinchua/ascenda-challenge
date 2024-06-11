class Location < ApplicationRecord
  validates :address, presence: true
  validates :country, presence: true
  validates :zipcode, presence: true
end
