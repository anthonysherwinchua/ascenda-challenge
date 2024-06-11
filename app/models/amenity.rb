class Amenity < ApplicationRecord
  validates :name, :category, presence: true
  validates :name, uniqueness: { scope: :category }
end
