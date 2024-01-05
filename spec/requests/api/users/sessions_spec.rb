# frozen_string_literal: true

require 'rails_helper'

describe 'api/users/sessions', type: :request do
  let(:user) { create(:user) }
  let(:login_url) { '/api/login' }
  let(:logout_url) { '/api/logout' }
end
