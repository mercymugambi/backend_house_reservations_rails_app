require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index, params: { user_id: 1 } # Provide a valid user_id here
      expect(response).to have_http_status(:success)
    end

    it 'returns JSON with reservations information' do
      user = FactoryBot.create(:user) # Assuming you have a factory for User
      house = FactoryBot.create(:house) # Assuming you have a factory for House
      FactoryBot.create(:reservation, user:, house:) # Assuming you have a factory for Reservation

      get :index, params: { user_id: user.id }
      json_response = JSON.parse(response.body)

      expect(json_response.size).to eq(1) # Check the size of the JSON response
      expect(json_response.first.keys).to include('id', 'user', 'house', 'city', 'date')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:user) { FactoryBot.create(:user) }
      let(:house) { FactoryBot.create(:house) }
      let(:valid_params) do
        { reservation: { user_id: user.id, house_id: house.id, city: 'City', date: Date.today } }
      end

      it 'creates a new reservation' do
        expect do
          post :create, params: valid_params
        end.to change(Reservation, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('notice' => 'Reservation was successfully created.')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        { reservation: { user_id: nil, house_id: nil, city: '', date: nil } }
      end

      it 'does not create a new reservation' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Reservation, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('reservation_id' => nil)
        expect(JSON.parse(response.body)['errors']).to include('User must exist', 'House must exist', "City can't be blank", "Date can't be blank")
      end
    end
  end

  # Add similar tests for other actions like show, update, and destroy
end
