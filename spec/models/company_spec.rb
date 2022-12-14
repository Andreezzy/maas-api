require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should have_many(:schedules) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:avatar) }
  it { should validate_presence_of(:description) }
end
