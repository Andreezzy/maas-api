require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:events) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:avatar) }
  it { should validate_presence_of(:color) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation) }

  it { should validate_uniqueness_of(:email) }
  it { should validate_length_of(:password).is_at_least(8) }
  it { should validate_length_of(:color).is_equal_to(7) }
end
