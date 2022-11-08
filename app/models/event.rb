class Event < ApplicationRecord
  belongs_to :schedule
  belongs_to :user, optional: true

  validates :kind, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  enum :kind, { draft: 0, published: 1 }
end
