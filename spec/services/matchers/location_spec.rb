require 'rails_helper'

RSpec.describe Matchers::Location do
  let(:location) do
    create(:location,
           latitude: 12.34,
           longitude: 56.78,
           address: 'Old Address',
           city: 'Old City',
           country: 'Old Country',
           zipcode: '12345')
  end
  let(:new_attributes) do
    {
      latitude: 12.3456,
      longitude: 56.7890,
      address: 'New Address',
      city: 'New City',
      country: 'New Country',
      zipcode: '67890'
    }
  end

  subject { described_class.new(location, new_attributes) }

  describe '#attributes' do
    it 'returns the combined attributes' do
      expected_attributes = {
        latitude: 12.3456,
        longitude: 56.7890,
        address: 'New Address',
        city: 'New City',
        country: 'New Country',
        zipcode: '67890'
      }
      expect(subject.attributes).to eq(expected_attributes)
    end
  end

  describe '#latitude' do
    it 'returns the more detailed latitude' do
      expect(subject.send(:latitude)).to eq(12.3456)
    end
  end

  describe '#longitude' do
    it 'returns the more detailed longitude' do
      expect(subject.send(:longitude)).to eq(56.7890)
    end
  end

  describe '#address' do
    it 'returns the longest address' do
      expect(subject.send(:address)).to eq('New Address')
    end
  end

  describe '#city' do
    it 'returns the longest city name' do
      expect(subject.send(:city)).to eq('New City')
    end
  end

  describe '#country' do
    it 'returns the longest country name' do
      expect(subject.send(:country)).to eq('New Country')
    end
  end

  describe '#zipcode' do
    it 'returns the longest zipcode' do
      expect(subject.send(:zipcode)).to eq('67890')
    end
  end
end
