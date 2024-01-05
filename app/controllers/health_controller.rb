class HealthController < ApplicationController
  def index
    render json: { status: 'Api is online' }, status: 200
  end
end
