# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Health Check', type: :request do
  describe 'GET /index' do
    it 'returns 200 ok and has a JSON message in the body' do
      # GET request to the index action of the HealthController
      get '/health/index'

      # Response is a special object that contains HTTP response received after the request is processed
      # response.body is the body of the HTTP response, in this case it will contain the JSON string
      expect(response.body).to eq('{"status":"api is online"}')

      # We can also check the HTTP status code of the response
      expect(response.status).to eq(200)
    end
  end
end
