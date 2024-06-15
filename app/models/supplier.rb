class Supplier < ApplicationRecord
  enum scrape_status: {
    started: 0,
    completed: 1
  }

  validates :name, :url, presence: true
  validates :name, uniqueness: true
end
