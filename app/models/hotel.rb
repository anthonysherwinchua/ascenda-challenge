# frozen_string_literal: true

class Hotel < ApplicationRecord
  acts_as_paranoid

  belongs_to :location
  has_and_belongs_to_many :amenities

  validates :hotel_id, :destination_id, presence: true
  validates :hotel_id, uniqueness: { scope: :destination_id }
end
