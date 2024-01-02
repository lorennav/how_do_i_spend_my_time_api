# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  deserializable_resource :user

  include RackSessionsFix
  respond_to :json

  private
  def respond_with(current_user, _opts = {})
    json_api_renderer = JSONAPI::Serializable::Renderer.new
    serialized_data = json_api_renderer.render(current_user, class: { User: SerializableUser })
    render json: {
      status: {
        code: 200, message: 'Logged in successfully.',
        data: { user: serialized_data[:data][:attributes] }
      }
    }, status: :ok
  end
  def respond_to_on_destroy
    authorization_header = request.headers['Authorization']
    jwt_secret = Rails.application.credentials.devise_jwt_secret_key!
    if authorization_header.present?
      jwt_payload = JWT.decode(authorization_header.split(' ').last, jwt_secret).first
      current_user = User.find(jwt_payload['sub'])
    end

    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
