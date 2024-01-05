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
    msg = 'Logged out successfully.'
    return handle_json_response(200, msg, :ok) if find_user_by_token.present?

    handle_json_response(401, "Can't find an active session", :unauthorized)
  end

  def find_user_by_token
    authorization_header = request.headers['Authorization']
    jwt_secret = Rails.application.credentials.devise_jwt_secret_key!
    return nil unless authorization_header.present?

    jwt_payload = JWT.decode(authorization_header.split(' ').last, jwt_secret).first
    User.find(jwt_payload['sub'])
  end

  def handle_json_response(status_no, message_text, status_sym)
    render json: {
      status: {
        code: status_no, message: message_text
      }
    }, status: status_sym
  end
end
