require 'rails_helper'

RSpec.describe BusinessHour, type: :model do
  it { should belong_to(:schedule) }

  it { should validate_presence_of(:day_of_week) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }

  it { should validate_inclusion_of(:day_of_week).in_range(0..6) }
end
