# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe HotelDataCleanerJob, type: :job do
  describe '#perform' do
    it 'calls HotelDataCleaner' do
      expect(::HotelDataCleaner).to receive(:call)
      described_class.new.perform
    end
  end
end
