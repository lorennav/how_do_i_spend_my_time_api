# frozen_string_literal: true

class Api::V1::ActivitiesController < ApplicationController
  include TimeFormatter

  before_action :authenticate_user!
  before_action :activity, only: [:update]

  def index
    @activities = current_user.activities
    render json: @activities
  end

  def create
    activity = current_user.activities.build(activity_params)
    return api_response(activity, :created) if activity.save

    api_response(activity.errors, :unprocessable_entity)
  end

  def update
    return api_response('Activity does not exist', :not_found) unless activity

    return api_response(activity, :ok) if activity.update(activity_params)

    api_response(activity.errors, :unprocessable_entity)
  end

  private

  def activity_params
    handle_time_params
    params.require(:activity).permit(:name, :description, :date, :start_time, :finish_time, :category_id)
  end

  def activity
    @activity = current_user.activities.find_by(id: params[:id])
  end

  def handle_time_params
    start_time = params[:activity][:start_time]
    finish_time = params[:activity][:finish_time]
    date = params[:activity][:date] || @activity&.date
    return unless date

    params[:activity][:start_time] = format_time(date, start_time) if start_time
    params[:activity][:finish_time] = format_time(date, finish_time) if finish_time
  end
end
