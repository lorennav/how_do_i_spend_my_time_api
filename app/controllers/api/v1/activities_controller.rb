# frozen_string_literal: true

class Api::V1::ActivitiesController < ApplicationController
  include TimeFormatter

  before_action :authenticate_user!
  def index
    @activities = current_user.activities
    render json: @activities
  end

  def create
    activity = build_activity
    return api_response(activity, :created) if activity.save

    api_response(activity.errors, :unprocessable_entity)
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :description, :date, :start_time, :finish_time, :category_id)
  end

  def build_activity
    date = activity_params[:date]
    current_user.activities.build(
      name: activity_params[:name],
      description: activity_params[:description],
      date:,
      start_time: format_time(date, activity_params[:start_time]),
      finish_time: format_time(date, activity_params[:finish_time]),
      category_id: activity_params[:category_id]
    )
  end
end
