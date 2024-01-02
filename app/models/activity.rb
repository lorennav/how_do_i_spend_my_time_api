class Activity < ApplicationRecord
  validates :name, :date, :start_time, presence: true
  belongs_to :category, optional: true
end
