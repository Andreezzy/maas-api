require 'rails_helper'

RSpec.describe Schedule, type: :model do
  it { should belong_to(:company) }
  it { should have_many(:business_hours) }

  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should validate_presence_of(:min_time) }
  it { should validate_presence_of(:max_time) }
end
