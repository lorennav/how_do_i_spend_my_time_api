# frozen_string_literal: true

class Api::UsersController < Api::BaseController
  before_action :find_user, only: %w[show]

  def show
    return render json: @user if @user

    render json: { status: { message: 'User not found' } }, status: :not_found
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
