require 'swagger_helper'

RSpec.describe 'api/v1/activities', type: :request do
  let(:user) { create(:user, :with_activities_and_categories) }
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, user) }
  let(:Authorization) { auth_headers['Authorization'] }

  path '/api/v1/activities' do
    get 'Retrieves all activities' do
      tags 'Activities'
      produces 'application/json', 'application/xml'
      security [Bearer: {}]

      response '200', 'activities found' do
        run_test!
      end
    end

    post 'Creates an activity' do
      tags 'Activities'
      consumes 'application/json'
      security [Bearer: {}]
      parameter name: :activity, in: :body, schema: { '$ref' => '#/components/schemas/activity' }
      response '201', 'activity created' do
        let(:activity) { { name: 'Study', date: '2021-09-01', start_time: '10:00', finish_time: '12:00' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:activity) { { name: 'Study' } }
        run_test!
      end
    end
  end

  path '/api/v1/activities/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    put 'Updates an activity' do
      tags 'Activities'
      consumes 'application/json'
      security [Bearer: {}]
      parameter name: :activity, in: :body, schema: { '$ref' => '#/components/schemas/activity' }
      response '200', 'activity updated' do
        let(:id) { user.activities.first&.id }
        let(:activity) { { name: 'New activity' } }
        run_test!
      end
    end
  end
end
