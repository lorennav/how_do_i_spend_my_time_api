# frozen_string_literal: true

class Api::V1::ActivitiesController < ApplicationController
  before_action :authenticate_user!
  def index
    activities = current_user.activities
    render jsonapi: activities
  end

  def create
    activity = current_user.activities.build(activity_params)
    if activity.save
      render jsonapi: activity, status: :created
    else
      render jsonapi_errors: activity.errors, status: :unprocessable_entity
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :description, :date, :start_time, :end_time)
  end
end
