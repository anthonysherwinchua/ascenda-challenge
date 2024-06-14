require 'rails_helper'

RSpec.describe Api::HotelsController, type: :controller do
  describe 'GET #index' do
    render_views

    before do
      create_list(:hotel, 2)

      get :index, format: :json
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a JSON response with hotels' do
      json_response = JSON.parse(response.body)

      expect(json_response.size).to eq(2)
    end
  end
end
