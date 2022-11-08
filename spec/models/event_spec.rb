require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:schedule) }
  it { should belong_to(:user).optional }

  it { should validate_presence_of(:kind) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }

  it { should define_enum_for(:kind) }
  it { should define_enum_for(:kind).with_values(draft: 0, published: 1) }

end
