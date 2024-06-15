# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Orm::Patagonia do
  let(:original_attributes) do
    {
      "id": 'iJhz',
      "destination": 5432,
      "name": 'Beach Villas Singapore',
      "lat": 1.264751,
      "lng": 103.824006,
      "address": '8 Sentosa Gateway, Beach Villas, 098269',
      "info": 'Located at the western tip of Resorts World Sentosa, guests at the Beach Villas are guaranteed privacy ' \
        'while they enjoy spectacular views of glittering waters. Guests will find themselves in paradise with this ' \
        'series of exquisite tropical sanctuaries, making it the perfect setting for an idyllic retreat. Within each ' \
        'villa, guests will discover living areas and bedrooms that open out to mini gardens, private timber sundecks ' \
        'and verandahs elegantly framing either lush greenery or an expanse of sea. Guests are assured of a superior ' \
        'slumber with goose feather pillows and luxe mattresses paired with 400 thread count Egyptian cotton bed linen, ' \
        'tastefully paired with a full complement of luxurious in-room amenities and bathrooms boasting rain showers ' \
        'and free-standing tubs coupled with an exclusive array of ESPA amenities and toiletries. Guests also get to ' \
        'enjoy complimentary day access to the facilities at Asia’s flagship spa – the world-renowned ESPA.',
      "amenities": [
        'Aircon',
        'Tv',
        'Coffee machine',
        'Kettle',
        'Hair dryer',
        'Iron',
        'Tub'
      ],
      "images": {
        "rooms": [
          {
            "url": 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg',
            "description": 'Double room'
          },
          {
            "url": 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg',
            "description": 'Bathroom'
          }
        ],
        "amenities": [
          {
            "url": 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/0.jpg',
            "description": 'RWS'
          },
          {
            "url": 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/6.jpg',
            "description": 'Sentosa Gateway'
          }
        ]
      }
    }
  end

  subject { described_class.new(original_attributes) }

  describe '#attributes' do
    it 'returns a cleaned hash of hotel attributes' do
      expect(subject.attributes).to eq(
        {
          name: 'Beach Villas Singapore',
          description: 'Located at the western tip of Resorts World Sentosa, guests at the Beach Villas are guaranteed privacy ' \
            'while they enjoy spectacular views of glittering waters. Guests will find themselves in paradise with this ' \
            'series of exquisite tropical sanctuaries, making it the perfect setting for an idyllic retreat. Within each ' \
            'villa, guests will discover living areas and bedrooms that open out to mini gardens, private timber sundecks ' \
            'and verandahs elegantly framing either lush greenery or an expanse of sea. Guests are assured of a superior ' \
            'slumber with goose feather pillows and luxe mattresses paired with 400 thread count Egyptian cotton bed linen, ' \
            'tastefully paired with a full complement of luxurious in-room amenities and bathrooms boasting rain showers ' \
            'and free-standing tubs coupled with an exclusive array of ESPA amenities and toiletries. Guests also get to ' \
            'enjoy complimentary day access to the facilities at Asia’s flagship spa – the world-renowned ESPA.',
          images: {
            rooms: [
              {
                link: 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg',
                description: 'Double room'
              },
              {
                link: 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg',
                description: 'Bathroom'
              }
            ],
            amenities: [
              {
                link: 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/0.jpg',
                description: 'RWS'
              },
              {
                link: 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/6.jpg',
                description: 'Sentosa Gateway'
              }
            ]
          }.stringify_keys,
          booking_conditions: nil
        }
      )
    end
  end

  describe '#location_attributes' do
    it 'returns a cleaned hash of location attributes' do
      expect(subject.location_attributes).to eq({
                                                  latitude: 1.264751,
                                                  longitude: 103.824006,
                                                  address: '8 Sentosa Gateway, Beach Villas',
                                                  city: nil,
                                                  country: nil,
                                                  zipcode: '098269'
                                                })
    end
  end

  describe '#amenities_attributes' do
    it 'returns the cleaned facilities as amenities' do
      expect(subject.amenities_attributes).to eq(
        {
          general: [
            'aircon',
            'tv',
            'coffee machine',
            'kettle',
            'hair dryer',
            'iron',
            'tub'
          ]
        }.stringify_keys
      )
    end
  end

  describe '#hotel_id' do
    it 'returns the hotel ID' do
      expect(subject.hotel_id).to eq('iJhz')
    end
  end

  describe '#destination_id' do
    it 'returns the destination ID' do
      expect(subject.destination_id).to eq(5432)
    end
  end

  describe '#name' do
    it 'returns the hotel name' do
      expect(subject.name).to eq('Beach Villas Singapore')
    end
  end

  describe '#description' do
    it 'returns the description' do
      expect(subject.description).to eq(
        'Located at the western tip of Resorts World Sentosa, guests at the Beach Villas are guaranteed privacy ' \
        'while they enjoy spectacular views of glittering waters. Guests will find themselves in paradise with this ' \
        'series of exquisite tropical sanctuaries, making it the perfect setting for an idyllic retreat. Within each ' \
        'villa, guests will discover living areas and bedrooms that open out to mini gardens, private timber sundecks ' \
        'and verandahs elegantly framing either lush greenery or an expanse of sea. Guests are assured of a superior ' \
        'slumber with goose feather pillows and luxe mattresses paired with 400 thread count Egyptian cotton bed linen, ' \
        'tastefully paired with a full complement of luxurious in-room amenities and bathrooms boasting rain showers ' \
        'and free-standing tubs coupled with an exclusive array of ESPA amenities and toiletries. Guests also get to ' \
        'enjoy complimentary day access to the facilities at Asia’s flagship spa – the world-renowned ESPA.'
      )
    end
  end

  describe '#images' do
    it 'returns the transformed images' do
      expected_images = {
        "rooms": [
          {
            "link": 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg',
            "description": 'Double room'
          },
          {
            "link": 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg',
            "description": 'Bathroom'
          }
        ],
        "amenities": [
          {
            "link": 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/0.jpg',
            "description": 'RWS'
          },
          {
            "link": 'https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/6.jpg',
            "description": 'Sentosa Gateway'
          }
        ]
      }.stringify_keys
      expect(subject.images).to eq(expected_images)
    end

    describe 'original attributes does not have images' do
      let(:original_attributes) { {} }

      it 'returns nil if images are not present' do
        expect(subject.images).to be_nil
      end
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
    it 'returns the address without the zipcode' do
      expect(subject.address).to eq('8 Sentosa Gateway, Beach Villas, ')
    end

    describe 'original attributes address does not have zipcode' do
      let(:original_attributes) do
        {
          address: '8 Sentosa Gateway, Beach Villas'
        }
      end

      it 'returns nil if address is not present' do
        expect(subject.address).to eq('8 Sentosa Gateway, Beach Villas')
      end
    end

    describe 'original attributes does not have address' do
      let(:original_attributes) { {} }

      it 'returns nil if address is not present' do
        expect(subject.address).to be_nil
      end
    end
  end

  describe '#zipcode' do
    it 'returns the zipcode from the address' do
      expect(subject.zipcode).to eq('098269')
    end

    describe 'original attributes does not have address' do
      let(:original_attributes) do
        {
          address: 'Beach Villas Singapore'
        }
      end

      it 'returns nil if no zipcode is present in the address' do
        expect(subject.zipcode).to be_nil
      end
    end
  end

  describe '#amenities' do
    it 'returns the amenities' do
      expect(subject.amenities).to eq({
                                        general: [
                                          'Aircon',
                                          'Tv',
                                          'Coffee machine',
                                          'Kettle',
                                          'Hair dryer',
                                          'Iron',
                                          'Tub'
                                        ]
                                      })
    end

    describe 'original attributes does not have address' do
      let(:original_attributes) { {} }

      it 'returns an empty array if amenities are not present' do
        expect(subject.amenities).to eq({ general: [] })
      end
    end
  end

  describe '#delete?' do
    it { expect(subject.delete?).to eq(false) }
  end
end
