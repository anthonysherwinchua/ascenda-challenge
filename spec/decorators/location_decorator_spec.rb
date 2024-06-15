# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LocationDecorator do
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

  subject { described_class.new(location) }

  it { expect(subject.address).to eq('Arab Street, 654321') }
  it do
    expect(subject.as_json).to eq(
      {
        lat: 1.23,
        lng: 1.45,
        address: 'Arab Street, 654321',
        city: 'Singapore',
        country: 'Singapore',
        created_at: nil,
        updated_at: nil,
        id: nil,
        latitude: 1.23,
        longitude: 1.45,
        zipcode: '654321'
      }.stringify_keys
    )
  end
end
