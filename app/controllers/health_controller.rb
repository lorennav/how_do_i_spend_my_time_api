class HealthController < ApplicationController
  def index
    render json: { status: 'api is online' }, status: 200
  end
end
