require 'rails_helper'

RSpec.describe Api::HotelsController, type: :request do
  describe 'GET #index' do
    it 'returns a JSON response with hotels data' do
      create_list(:hotel, 3)

      get '/api/hotels', params: {}, headers: { 'Accept' => 'application/json' }

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(3)

      expected_response = HotelsPresenter.new.call.to_a.map do |hotel|
        {
          id: hotel.id,
          destination_id: hotel.destination_id,
          name: hotel.name,
          description: hotel.description,
          amenities: hotel.amenities,
          images: hotel.images,
          booking_conditions: hotel.booking_conditions,
          location: hotel.location
        }.stringify_keys
      end

      expect(json_response).to match_array(expected_response)
    end
  end
end