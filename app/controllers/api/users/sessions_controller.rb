# frozen_string_literal: true

class Api::Users::SessionsController < Devise::SessionsController
  include RackSessionsFix
  respond_to :json

  private

  def respond_with(current_user, _opts = {})
    render json: {
      status: {
        code: 200, message: 'Logged in successfully.',
        data: { user: UserSerializer.new(current_user).serializable_hash }
      }
    }, status: :ok
  end

  def respond_to_on_destroy
    return destroy_success if find_user_by_token.present?

    no_session_error
  end

  def find_user_by_token
    authorization_header = request.headers['Authorization']
    jwt_secret = Rails.application.credentials.devise_jwt_secret_key!
    return no_session_error unless authorization_header.present?

    jwt_payload = JWT.decode(authorization_header.split(' ').last, jwt_secret).first
    User.find(jwt_payload['sub'])
  end

  def destroy_success
    render json: {
      status: 200,
      message: 'Logged out successfully.'
    }, status: :ok
  end

  def no_session_error
    render json: {
      status: 401,
      message: "Couldn't find an active session."
    }, status: :unauthorized
  end
end
