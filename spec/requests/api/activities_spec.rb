require 'swagger_helper'

RSpec.describe 'api/activities', type: :request do
  path '/api/v1/activities' do
    get 'Retrieves all activities' do
      tags 'Activities'
      produces 'application/json', 'application/xml'

      response '200', 'activities found' do
        run_test!
      end
    end

    post 'Creates a activity' do
      tags 'Activities'
      consumes 'application/json'
      parameter name: :activity, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          date: { type: :string },
          start_time: { type: :string },
          finish_time: { type: :string },
          category: { type: :object }
        },
        required: %w[name date start_time finish_time]
      }
      response '201', 'activity created' do
        let(:activity) { { name: 'Study', date: '2021-09-01', start_time: '10:00:00', finish_time: '12:00:00' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:activity) { { name: 'Study' } }
        run_test!
      end
    end
  end
end
