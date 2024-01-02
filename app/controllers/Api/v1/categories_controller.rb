class Api::V1::CategoriesController < ApplicationController

  def index
    categories = Category.all
    render jsonapi: categories
  end

  def create
    category = Category.new(activity_params)
    if category.save
      render jsonapi: category, status: :created
    else
      render jsonapi_errors: category.errors, status: :unprocessable_entity
    end
  end

  private

  def activity_params
    params.require(:category).permit(:name)
  end
end