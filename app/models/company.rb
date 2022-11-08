class Company < ApplicationRecord
  has_many :schedules

  validates :name, presence: true
  validates :avatar, presence: true
  validates :description, presence: true
end
