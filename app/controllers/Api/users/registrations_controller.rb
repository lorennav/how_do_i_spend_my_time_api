# frozen_string_literal: true

class Api::Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  respond_to :json

  private

  def respond_with(current_user, _opts = {})
    json_api_renderer = JSONAPI::Serializable::Renderer.new
    serialized_data = json_api_renderer.render(current_user, class: { User: SerializableUser })
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Signed up successfully.' },
        data: serialized_data[:data][:attributes]
      }
    else
      render json: {
        status: { message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
end
