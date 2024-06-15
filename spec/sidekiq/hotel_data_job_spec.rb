require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe HotelDataJob, type: :job do
  let(:supplier) { create(:supplier) }
  let(:supplier_id) { supplier.id }

  describe '#perform' do
    it 'calls HotelData with the supplier_id' do
      expect_any_instance_of(HotelData).to receive(:call)
      described_class.new.perform(supplier_id)
    end

    it 'enqueues the job' do
      expect {
        described_class.perform_async(supplier_id)
      }.to change(described_class.jobs, :size).by(1)
    end
  end
end
