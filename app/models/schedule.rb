class Schedule < ApplicationRecord
  belongs_to :company
  has_many :events, dependent: :destroy
  has_many :business_hours, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :min_time, presence: true
  validates :max_time, presence: true
end
