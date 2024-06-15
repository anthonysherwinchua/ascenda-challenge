class HotelDataCleanerJob
  include Sidekiq::Job

  def perform
    ::HotelDataCleaner.call
  end
end
