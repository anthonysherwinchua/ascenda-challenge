# frozen_string_literal: true

class Amenity < ApplicationRecord
  has_and_belongs_to_many :hotels

  validates :name, :category, presence: true
  validates :name, uniqueness: { scope: :category }
end
