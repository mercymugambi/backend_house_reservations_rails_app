# spec/integration/user_spec.rb

require 'swagger_helper'

RSpec.describe 'Api::V1::UsersController', type: :request do
  path '/api/v1/users' do
    get 'Fetches a list of users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'list of users' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   email: { type: :string }
                 },
                 required: %w[id email]
               }

        before { create_list(:user, 3) }

        run_test!
      end
    end

    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '201', 'user created' do
        let(:user) { attributes_for(:user) }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { email: '' } }
        run_test!
      end
    end
  end
end
