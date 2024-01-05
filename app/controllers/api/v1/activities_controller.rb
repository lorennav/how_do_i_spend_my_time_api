# frozen_string_literal: true

class Api::V1::ActivitiesController < ApplicationController
  before_action :authenticate_user!
  def index
    @activities = current_user.activities
    render json: @activities
  end

  def create
    activity = current_user.activities.build(activity_params)
    return api_response(activity, :created) if activity.save

    api_response(activity.errors, :unprocessable_entity)
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :description, :date, :start_time, :end_time)
  end
end
