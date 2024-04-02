class Activity < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :user

  validates :name, :date, :start_time, :finish_time, presence: true
end
