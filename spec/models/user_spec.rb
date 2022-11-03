require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validates_presence_of(:name) }
  it { should validates_presence_of(:last_name) }
  it { should validates_presence_of(:email) }
  it { should validates_presence_of(:password) }

  it { should validates_uniqueness_of(:email) }
  it { should validates_length_of(:password).is_at_least(8) }
end
