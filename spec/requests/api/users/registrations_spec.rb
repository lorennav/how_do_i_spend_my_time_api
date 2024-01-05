# frozen_string_literal: true

require 'rails_helper'

describe Api::Users::RegistrationsController, type: :request do
  let(:user) { build(:user) }
  let(:created_user) { create(:user) }
  let(:signup_url) { '/api/signup' }

  describe 'POST /signup' do
    context 'when user is valid' do
      before do
        post signup_url, params: { user: { email: user.email, password: user.password, name: user.name } }
      end

      it 'returns 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns success message' do
        expect(message).to match(/Signed up successfully./)
      end

      it 'returns an authentication token' do
        expect(response.headers['Authorization']).to be_present
      end
    end

    context 'when user is invalid' do
      before { post signup_url, params: { user: { email: nil, password: nil, name: nil } } }

      it 'returns 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns failure message' do
        expect(message).to match(/Email can't be blank, Password can't be blank/)
      end
    end
  end
end
