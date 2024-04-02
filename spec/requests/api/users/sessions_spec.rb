# frozen_string_literal: true

require 'rails_helper'

describe 'api/users/sessions', type: :request do
  let(:user) { create(:user) }
  let(:user_params) { { user: { email: user.email, password: user.password } } }
  let(:login_url) { '/api/login' }
  let(:logout_url) { '/api/logout' }
  let(:login_with_api) { post login_url, params: user_params }

  describe 'POST /api/login' do
    context 'with valid params' do
      before { login_with_api }
      it 'logs in the user' do
        expect(response.status).to eq(200)
      end

      it 'returns success message' do
        expect(message).to match(/Logged in successfully./)
      end

      it 'returns an authentication token' do
        expect(response.headers['Authorization']).to be_present
      end
    end

    context 'with invalid params' do
      before { post login_url, params: { user: { email: 'wrong_email', password: '' } } }

      it 'returns 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns failure message' do
        expect(response.body).to match(/Invalid Email or password./)
      end
    end
  end

  describe 'DELETE /api/logout' do
    before do
      login_with_api
      auth_headers = response.headers.slice('Authorization')
      delete logout_url, headers: auth_headers
    end

    it 'logs out the user' do
      expect(response.status).to eq(200)
    end

    it 'returns success message' do
      expect(message).to match(/Logged out successfully./)
    end
  end
end
