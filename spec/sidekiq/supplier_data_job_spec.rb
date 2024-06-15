# spec/jobs/supplier_data_job_spec.rb
require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe SupplierDataJob, type: :job do
  let!(:supplier1) { create(:supplier, name: 'Acme') }
  let!(:supplier2) { create(:supplier, name: 'Patagonia') }

  describe '#perform' do
    context 'when specific supplier names are provided' do
      it 'enqueues HotelDataJob for the given suppliers' do
        expect(HotelDataJob).to receive(:perform_async).with(supplier1.id).and_call_original
        expect(HotelDataJob).to receive(:perform_async).with(supplier2.id).and_call_original

        described_class.new.perform(%w[Acme Patagonia])
      end
    end

    context 'when no supplier names are provided' do
      it 'enqueues HotelDataJob for all suppliers' do
        expect(HotelDataJob).to receive(:perform_async).with(supplier1.id).and_call_original
        expect(HotelDataJob).to receive(:perform_async).with(supplier2.id).and_call_original

        described_class.new.perform
      end
    end

    context 'when provided supplier names do not match any suppliers' do
      it 'enqueues HotelDataJob for all suppliers' do
        expect(HotelDataJob).to receive(:perform_async).with(supplier1.id).and_call_original
        expect(HotelDataJob).to receive(:perform_async).with(supplier2.id).and_call_original

        described_class.new.perform(['NonExistentSupplier'])
      end
    end
  end
end
