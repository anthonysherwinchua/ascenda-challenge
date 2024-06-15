require 'rails_helper'

RSpec.describe HotelDataCleaner, type: :model do
  context "all suppliers are in completed state" do
    before do
      create(:hotel, scrape_job_id: nil)
      create(:hotel, scrape_job_id: SecureRandom.hex)

      job_id1 = SecureRandom.hex
      job_id2 = SecureRandom.hex
      create(:supplier, scrape_status: :completed, scrape_job_id: job_id1)
      create(:supplier, scrape_status: :completed, scrape_job_id: job_id2)

      create(:hotel, scrape_job_id: job_id1)
      create(:hotel, scrape_job_id: job_id2)
      create(:hotel, scrape_job_id: job_id1)
    end

    it { expect { HotelDataCleaner.call }.to change { Hotel.count }.by(-2) }
  end

  context "there is a supplier that is still in started scrape state" do
    let(:scrape_job_ids) do
      [
        SecureRandom.hex
      ]
    end

    before do
      create(:supplier, scrape_status: :started)
      create_list(:hotel, 2)
      create(:hotel, scrape_job_id: scrape_job_ids)
    end

    it { expect { HotelDataCleaner.call }.not_to change { Hotel.count } }
  end
end
