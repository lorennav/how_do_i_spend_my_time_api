# frozen_string_literal: true

module ApiHelpers
  def json
    JSON.parse(response.body)
  end

  def message
    json['status']['message']
  end

  def login_with_api(user)
    post '/api/login', params: {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end
end
