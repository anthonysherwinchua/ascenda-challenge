# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HotelDecorator do
  let(:name) { 'Marina bay sands' }
  let(:location) do
    build(:location, {
            latitude: 1.23,
            longitude: 1.45,
            address: 'Arab Street',
            zipcode: 654_321,
            city: 'Singapore',
            country: 'Singapore'
          })
  end
  let(:general_amenities) { build_list(:amenity, 2, category: 'general') }
  let(:room_amenities) { build_list(:amenity, 2, category: 'room') }
  let(:amenities) do
    general_amenities + room_amenities
  end
  let(:hotel) { build(:hotel, name: name, location: location, amenities: amenities) }

  subject { described_class.new(hotel) }

  it { expect(subject.id).to eq(hotel.hotel_id) }
  it { expect(subject.name).to eq('Marina Bay Sands') }
  it do
    expect(subject.location).to eq(
      {
        lat: 1.23,
        lng: 1.45,
        address: 'Arab Street, 654321',
        city: 'Singapore',
        country: 'Singapore'
      }.stringify_keys
    )
  end
  it do
    expect(subject.amenities).to eq(
      {
        general: general_amenities.map(&:name),
        room: room_amenities.map(&:name)
      }.stringify_keys
    )
  end
end
