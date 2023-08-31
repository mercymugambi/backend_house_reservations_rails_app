require 'rails_helper'

RSpec.describe Api::V1::HousesController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns JSON with list of houses' do
      # Assuming you have some houses created, or you can create them using FactoryBot
      FactoryBot.create_list(:house, 3)

      get :index
      json_response = JSON.parse(response.body)

      expect(json_response.size).to eq(3) # Check the size of the JSON response
      expect(json_response.first.keys).to include('id', 'house_name', 'city', 'description', 'bedrooms', 'bathrooms', 'rent', 'security_deposit', 'contact_phone_number', 'admin_user_id')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        { house: attributes_for(:house) } # Assuming you have a factory for House
      end

      it 'creates a new house' do
        expect do
          post :create, params: valid_params
        end.to change(House, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('status' => 'success', 'message' => 'House created successfully!')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        { house: { house_name: '' } } # Invalid params to trigger validation error
      end

      it 'does not create a new house' do
        expect do
          post :create, params: invalid_params
        end.not_to change(House, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('status' => 'failed')
        expect(JSON.parse(response.body)['errors']).to include("House name can't be blank")
      end
    end
  end

  # Add similar tests for other actions like show, update, destroy, unique_cities, and unique_houses
end
