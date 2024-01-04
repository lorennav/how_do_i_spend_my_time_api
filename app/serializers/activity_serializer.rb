class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :date, :start_time, :finish_time, :category

  belongs_to :category
  belongs_to :user
end
