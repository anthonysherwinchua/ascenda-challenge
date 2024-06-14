require 'rails_helper'

RSpec.describe Orm::Paperflies do
  let(:original_attributes) do
    {
      "hotel_id": "iJhz",
      "destination_id": 5432,
      "hotel_name": "Beach Villas Singapore",
      "location": {
        "address": "8 Sentosa Gateway, Beach Villas, 098269",
        "country": "Singapore"
      },
      "details": "Surrounded by tropical gardens, these upscale villas in elegant Colonial-style buildings are part of the Resorts World Sentosa complex and a 2-minute walk from the Waterfront train station. Featuring sundecks and pool, garden or sea views, the plush 1- to 3-bedroom villas offer free Wi-Fi and flat-screens, as well as free-standing baths, minibars, and tea and coffeemaking facilities. Upgraded villas add private pools, fridges and microwaves; some have wine cellars. A 4-bedroom unit offers a kitchen and a living room. There's 24-hour room and butler service. Amenities include posh restaurant, plus an outdoor pool, a hot tub, and free parking.",
      "amenities": {
        "general": [
          "outdoor pool",
          "indoor pool",
          "business center",
          "childcare"
        ],
        "room": [
          "tv",
          "coffee machine",
          "kettle",
          "hair dryer",
          "iron"
        ]
      },
      "images": {
        "rooms": [
          {
            "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg",
            "caption": "Double room"
          },
          {
            "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/3.jpg",
            "caption": "Double room"
          }
        ],
        "site": [
          {
            "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/1.jpg",
            "caption": "Front"
          }
        ]
      },
      "booking_conditions": [
        "All children are welcome. One child under 12 years stays free of charge when using existing beds. One child under 2 years stays free of charge in a child's cot/crib. One child under 4 years stays free of charge when using existing beds. One older child or adult is charged SGD 82.39 per person per night in an extra bed. The maximum number of children's cots/cribs in a room is 1. There is no capacity for extra beds in the room.",
        "Pets are not allowed.",
        "WiFi is available in all areas and is free of charge.",
        "Free private parking is possible on site (reservation is not needed).",
        "Guests are required to show a photo identification and credit card upon check-in. Please note that all Special Requests are subject to availability and additional charges may apply. Payment before arrival via bank transfer is required. The property will contact you after you book to provide instructions. Please note that the full amount of the reservation is due before arrival. Resorts World Sentosa will send a confirmation with detailed payment information. After full payment is taken, the property's details, including the address and where to collect keys, will be emailed to you. Bag checks will be conducted prior to entry to Adventure Cove Waterpark. === Upon check-in, guests will be provided with complimentary Sentosa Pass (monorail) to enjoy unlimited transportation between Sentosa Island and Harbour Front (VivoCity). === Prepayment for non refundable bookings will be charged by RWS Call Centre. === All guests can enjoy complimentary parking during their stay, limited to one exit from the hotel per day. === Room reservation charges will be charged upon check-in. Credit card provided upon reservation is for guarantee purpose. === For reservations made with inclusive breakfast, please note that breakfast is applicable only for number of adults paid in the room rate. Any children or additional adults are charged separately for breakfast and are to paid directly to the hotel."
      ]
    }
  end

  subject { described_class.new(original_attributes) }

  describe "#attributes" do
    it "returns a cleaned hash of hotel attributes" do
      expect(subject.attributes).to eq({
        name: "Beach Villas Singapore",
        description: "Surrounded by tropical gardens, these upscale villas in elegant Colonial-style buildings are part of the Resorts World Sentosa complex and a 2-minute walk from the Waterfront train station. Featuring sundecks and pool, garden or sea views, the plush 1- to 3-bedroom villas offer free Wi-Fi and flat-screens, as well as free-standing baths, minibars, and tea and coffeemaking facilities. Upgraded villas add private pools, fridges and microwaves; some have wine cellars. A 4-bedroom unit offers a kitchen and a living room. There's 24-hour room and butler service. Amenities include posh restaurant, plus an outdoor pool, a hot tub, and free parking.",
        images: {
          rooms: [
            {
              link: "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg",
              description: "Double room"
            },
            {
              link: "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/3.jpg",
              description: "Double room"
            }
          ],
          site: [
            {
              link: "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/1.jpg",
              description: "Front"
            }
          ]
        }.stringify_keys,
        booking_conditions: [
          "All children are welcome. One child under 12 years stays free of charge when using existing beds. One child under 2 years stays free of charge in a child's cot/crib. One child under 4 years stays free of charge when using existing beds. One older child or adult is charged SGD 82.39 per person per night in an extra bed. The maximum number of children's cots/cribs in a room is 1. There is no capacity for extra beds in the room.",
          "Pets are not allowed.",
          "WiFi is available in all areas and is free of charge.",
          "Free private parking is possible on site (reservation is not needed).",
          "Guests are required to show a photo identification and credit card upon check-in. Please note that all Special Requests are subject to availability and additional charges may apply. Payment before arrival via bank transfer is required. The property will contact you after you book to provide instructions. Please note that the full amount of the reservation is due before arrival. Resorts World Sentosa will send a confirmation with detailed payment information. After full payment is taken, the property's details, including the address and where to collect keys, will be emailed to you. Bag checks will be conducted prior to entry to Adventure Cove Waterpark. === Upon check-in, guests will be provided with complimentary Sentosa Pass (monorail) to enjoy unlimited transportation between Sentosa Island and Harbour Front (VivoCity). === Prepayment for non refundable bookings will be charged by RWS Call Centre. === All guests can enjoy complimentary parking during their stay, limited to one exit from the hotel per day. === Room reservation charges will be charged upon check-in. Credit card provided upon reservation is for guarantee purpose. === For reservations made with inclusive breakfast, please note that breakfast is applicable only for number of adults paid in the room rate. Any children or additional adults are charged separately for breakfast and are to paid directly to the hotel."
        ]
      })
    end
  end

  describe "#location_attributes" do
    it "returns a cleaned hash of location attributes" do
      expect(subject.location_attributes).to eq({
        latitude: nil,
        longitude: nil,
        address: "8 Sentosa Gateway, Beach Villas",
        city: nil,
        country: "Singapore",
        zipcode: "098269"
      })
    end
  end

  describe "#amenities_attributes" do
    it 'returns the cleaned facilities as amenities' do
      expect(subject.amenities_attributes).to eq(
        {
          general: [
            "outdoor pool",
            "indoor pool",
            "business center",
            "childcare"
          ],
          room: [
            "tv",
            "coffee machine",
            "kettle",
            "hair dryer",
            "iron"
          ]
        }.stringify_keys
      )
    end
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
    it 'returns the hotel name' do
      expect(subject.name).to eq("Beach Villas Singapore")
    end
  end

  describe '#description' do
    it 'returns the description' do
      expect(subject.description).to eq("Surrounded by tropical gardens, these upscale villas in elegant Colonial-style buildings are part of the Resorts World Sentosa complex and a 2-minute walk from the Waterfront train station. Featuring sundecks and pool, garden or sea views, the plush 1- to 3-bedroom villas offer free Wi-Fi and flat-screens, as well as free-standing baths, minibars, and tea and coffeemaking facilities. Upgraded villas add private pools, fridges and microwaves; some have wine cellars. A 4-bedroom unit offers a kitchen and a living room. There's 24-hour room and butler service. Amenities include posh restaurant, plus an outdoor pool, a hot tub, and free parking.")
    end
  end

  describe '#images' do
    it 'returns the transformed images' do
      expected_images = {
        "rooms": [
          {
            "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg",
            "description": "Double room"
          },
          {
            "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/3.jpg",
            "description": "Double room"
          }
        ],
        "site": [
          {
            "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/1.jpg",
            "description": "Front"
          }
        ]
      }.stringify_keys
      expect(subject.images).to eq(expected_images)
    end

    describe "original attributes does not have images key" do
      let(:original_attributes) { {} }

      it 'returns nil if images are not present' do
        expect(subject.images).to be_nil
      end
    end
  end

  describe '#booking_conditions' do
    it 'returns the booking conditions' do
      expect(subject.booking_conditions).to eq([
        "All children are welcome. One child under 12 years stays free of charge when using existing beds. One child under 2 years stays free of charge in a child's cot/crib. One child under 4 years stays free of charge when using existing beds. One older child or adult is charged SGD 82.39 per person per night in an extra bed. The maximum number of children's cots/cribs in a room is 1. There is no capacity for extra beds in the room.",
        "Pets are not allowed.",
        "WiFi is available in all areas and is free of charge.",
        "Free private parking is possible on site (reservation is not needed).",
        "Guests are required to show a photo identification and credit card upon check-in. Please note that all Special Requests are subject to availability and additional charges may apply. Payment before arrival via bank transfer is required. The property will contact you after you book to provide instructions. Please note that the full amount of the reservation is due before arrival. Resorts World Sentosa will send a confirmation with detailed payment information. After full payment is taken, the property's details, including the address and where to collect keys, will be emailed to you. Bag checks will be conducted prior to entry to Adventure Cove Waterpark. === Upon check-in, guests will be provided with complimentary Sentosa Pass (monorail) to enjoy unlimited transportation between Sentosa Island and Harbour Front (VivoCity). === Prepayment for non refundable bookings will be charged by RWS Call Centre. === All guests can enjoy complimentary parking during their stay, limited to one exit from the hotel per day. === Room reservation charges will be charged upon check-in. Credit card provided upon reservation is for guarantee purpose. === For reservations made with inclusive breakfast, please note that breakfast is applicable only for number of adults paid in the room rate. Any children or additional adults are charged separately for breakfast and are to paid directly to the hotel."
      ])
    end
  end

  describe '#address' do
    it 'returns the address without the zipcode' do
      expect(subject.address).to eq("8 Sentosa Gateway, Beach Villas, ")
    end

    describe "original attributes address does not have zipcode" do
      let(:original_attributes) do
        {
          "location": {
            "address": "8 Sentosa Gateway, Beach Villas"
          }
        }
      end

      it 'returns the address as is if no zipcode is present' do
        expect(subject.address).to eq("8 Sentosa Gateway, Beach Villas")
      end
    end

    describe "original attributes does not have address key" do
      let(:original_attributes) { {} }

      it 'returns nil if address is not present' do
        expect(subject.address).to be_nil
      end
    end
  end

  describe '#country' do
    it 'returns the country' do
      expect(subject.country).to eq("Singapore")
    end
  end

  describe '#zipcode' do
    it 'returns the zipcode from the address' do
      expect(subject.zipcode).to eq("098269")
    end

    describe "original attributes address does not have zipcode" do
      let(:original_attributes) do
        {
          "location": {
            "address": "8 Sentosa Gateway, Beach Villas"
          }
        }
      end

      it 'returns nil if no zipcode is present in the address' do
        expect(subject.zipcode).to be_nil
      end
    end
  end

  describe '#amenities' do
    it 'returns the amenities' do
      expect(subject.amenities).to eq(
        {
          general: [
            "outdoor pool",
            "indoor pool",
            "business center",
            "childcare"
          ],
          room: [
            "tv",
            "coffee machine",
            "kettle",
            "hair dryer",
            "iron"
          ]
        }.stringify_keys
      )
    end

    describe "original attributes does not have amenities" do
      let(:original_attributes) { {} }

      it 'returns an empty array if amenities are not present' do
        expect(subject.amenities).to eq([])
      end
    end
  end
end
