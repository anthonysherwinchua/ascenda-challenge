# frozen_string_literal: true

class HotelDataCleanerJob
  include Sidekiq::Job

  def perform
    ::HotelDataCleaner.call
  end
end
