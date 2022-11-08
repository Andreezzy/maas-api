class Schedule < ApplicationRecord
  belongs_to :company
  has_many :business_hours

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :min_time, presence: true
  validates :max_time, presence: true
end
