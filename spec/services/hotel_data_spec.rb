require 'rails_helper'

RSpec.describe HotelData, type: :model do
  let(:supplier) { create(:supplier, name: 'patagonia', url: 'http://example.com/data') }
  let(:supplier_id) { supplier.id }
  let(:response_body) do
    [
      {
        "id": "iJhz",
        "destination": 5432,
        "name": "Beach Villas Singapore",
        "lat": 1.264751,
        "lng": 103.824006,
        "address": "8 Sentosa Gateway, Beach Villas, 098269",
        "info": "Located at the western tip of Resorts World Sentosa, guests at the Beach Villas are guaranteed privacy while they enjoy spectacular views of glittering waters. Guests will find themselves in paradise with this series of exquisite tropical sanctuaries, making it the perfect setting for an idyllic retreat. Within each villa, guests will discover living areas and bedrooms that open out to mini gardens, private timber sundecks and verandahs elegantly framing either lush greenery or an expanse of sea. Guests are assured of a superior slumber with goose feather pillows and luxe mattresses paired with 400 thread count Egyptian cotton bed linen, tastefully paired with a full complement of luxurious in-room amenities and bathrooms boasting rain showers and free-standing tubs coupled with an exclusive array of ESPA amenities and toiletries. Guests also get to enjoy complimentary day access to the facilities at Asia’s flagship spa – the world-renowned ESPA.",
        "amenities": [
          "Aircon",
          "Tv",
          "Coffee machine",
          "Kettle",
          "Hair dryer",
          "Iron",
          "Tub"
        ],
        "images": {
          "rooms": [
            {
              "url": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg",
              "description": "Double room"
            },
            {
              "url": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg",
              "description": "Bathroom"
            }
          ],
          "amenities": [
            {
              "url": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/0.jpg",
              "description": "RWS"
            },
            {
              "url": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/6.jpg",
              "description": "Sentosa Gateway"
            }
          ]
        }
      },
      {
        "id": "f8c9",
        "destination": 1122,
        "name": "Hilton Tokyo Shinjuku",
        "lat": 35.6926,
        "lng": 139.690965,
        "address": nil,
        "info": nil,
        "amenities": nil,
        "images": {
          "rooms": [
            {
              "url": "https://d2ey9sqrvkqdfs.cloudfront.net/YwAr/i10_m.jpg",
              "description": "Suite"
            },
            {
              "url": "https://d2ey9sqrvkqdfs.cloudfront.net/YwAr/i11_m.jpg",
              "description": "Suite - Living room"
            }
          ],
          "amenities": [
            {
              "url": "https://d2ey9sqrvkqdfs.cloudfront.net/YwAr/i57_m.jpg",
              "description": "Bar"
            }
          ]
        }
      }
    ].to_json
  end

  subject { described_class.new(supplier_id) }

  before do
    allow(HTTParty).to receive(:get).with(supplier.url).and_return(double(body: response_body))
  end

  describe '#call' do
    context 'when ORM is found' do
      it 'processes and saves hotel data' do
        expect { subject.call }.to change { Hotel.count }.by(2)
      end
    end

    context 'when ORM is not found' do
      before do
        supplier.update!(name: 'unknown_supplier')
      end

      it 'returns ORM not found message' do
        expect(subject.call).to eq("ORM not found for unknown_supplier")
      end
    end

    context 'when response is invalid' do
      before do
        allow(HTTParty).to receive(:get).with(supplier.url).and_return(double(body: 'invalid_json'))
      end

      it 'does not raise an error' do
        expect { subject.call }.not_to raise_error
      end
    end
  end

  describe '#save' do
    let(:attributes) { JSON.parse(response_body).first }

    it 'saves hotel data' do
      expect { subject.save(attributes) }.to change { Hotel.count }.by(1)
    end

    it 'updates location data' do
      hotel = create(:hotel, hotel_id: attributes["id"], destination_id: attributes["destination"])
      location = create(:location, hotel: hotel, address: 'old address')

      expect { subject.save(attributes) }.to change { location.reload.address }.to("8 Sentosa Gateway, Beach Villas")
    end

    it 'creates new amenities' do
      expect { subject.save(attributes) }.to change { Amenity.count }.by(7)
    end
  end
end
