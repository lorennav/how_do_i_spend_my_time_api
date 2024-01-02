class Api::V1::ActivitiesController < ApplicationController

  def index
    activities = Activity.all
    render jsonapi: activities
  end

  def create
    activity = Activity.new(activity_params)
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