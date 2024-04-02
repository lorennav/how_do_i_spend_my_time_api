# frozen_string_literal: true

class Api::V1::CategoriesController < ApplicationController
  before_action :authenticate_user!
  def index
    categories = Category.all
    render json: categories
  end

  def create
    category = current_user.categories.build(category_params)
    return api_response(category, :created) if category.save

    api_response(category.errors, :unprocessable_entity)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
