class Company < ApplicationRecord
  validates :name, presence: true
  validates :avatar, presence: true
  validates :description, presence: true
end
