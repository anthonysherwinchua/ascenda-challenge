require 'rails_helper'

RSpec.describe Orm::Acme do
  let(:original_attributes) do
    {
      "Id": "iJhz",
      "DestinationId": 5432,
      "Name": "Beach Villas Singapore",
      "Latitude": 1.264751,
      "Longitude": 103.824006,
      "Address": " 8 Sentosa Gateway, Beach Villas ",
      "City": "Singapore",
      "Country": "SG",
      "PostalCode": "098269",
      "Description": "  This 5 star hotel is located on the coastline of Singapore.",
      "Facilities": [
        "Pool",
        "BusinessCenter",
        "WiFi ",
        "DryCleaning",
        " Breakfast"
      ]
    }
  end

  subject { described_class.new(original_attributes) }

  describe "#attributes" do
    it "returns a cleaned hash of hotel attributes" do
      expect(subject.attributes).to eq({
        name: "Beach Villas Singapore",
        description: "This 5 star hotel is located on the coastline of Singapore.",
        images: nil,
        booking_conditions: nil
      })
    end
  end

  describe "#location_attributes" do
    it "returns a cleaned hash of location attributes" do
      expect(subject.location_attributes).to eq({
        latitude: 1.264751,
        longitude: 103.824006,
        address: "8 Sentosa Gateway, Beach Villas",
        city: "Singapore",
        country: "SG",
        zipcode: "098269"
      })
    end
  end

  describe "#amenities_attributes" do
    it 'returns the cleaned facilities as amenities' do
      expect(subject.amenities_attributes).to eq(
        {
          general: [
            "pool",
            "business center",
            "wi fi",
            "dry cleaning",
            "breakfast"
          ]
        }.stringify_keys
      )
    end
  end

  describe "#sanitized_booking_conditions" do
    it { expect(subject.sanitized_booking_conditions).to(eq(nil)) }
  end

  describe '#hotel_id' do
    it 'returns the hotel ID' do
      expect(subject.hotel_id).to eq("iJhz")
    end
  end

  describe '#destination_id' do
    it 'returns the destination ID' do
      expect(subject.destination_id).to eq(5432)
    end
  end

  describe '#name' do
    it 'returns the name' do
      expect(subject.name).to eq("Beach Villas Singapore")
    end
  end

  describe '#description' do
    it 'returns the description' do
      expect(subject.description).to eq("  This 5 star hotel is located on the coastline of Singapore.")
    end
  end

  describe '#latitude' do
    it 'returns the latitude' do
      expect(subject.latitude).to eq(1.264751)
    end
  end

  describe '#longitude' do
    it 'returns the longitude' do
      expect(subject.longitude).to eq(103.824006)
    end
  end

  describe '#address' do
    it 'returns the address' do
      expect(subject.address).to eq(" 8 Sentosa Gateway, Beach Villas ")
    end
  end

  describe '#city' do
    it 'returns the city' do
      expect(subject.city).to eq("Singapore")
    end
  end

  describe '#country' do
    it 'returns the country' do
      expect(subject.country).to eq("SG")
    end
  end

  describe '#zipcode' do
    it 'returns the postal code' do
      expect(subject.zipcode).to eq("098269")
    end
  end

  describe '#amenities' do
    it 'returns the facilities as amenities' do
      expect(subject.amenities).to eq(
        {
          general: [
            "Pool",
            "BusinessCenter",
            "WiFi ",
            "DryCleaning",
            " Breakfast"
          ]
        }
      )
    end

    describe "original attributes does not have Facilities key" do
      let(:original_attributes) { {} }

      it 'returns an empty array if facilities are not present' do
        expect(subject.amenities).to eq({ general: [] })
      end
    end
  end

  describe "#delete?" do
    it { expect(subject.delete?).to eq(false) }
  end
end
