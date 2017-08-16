require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { is_expected.to belong_to(:user) }
  # it { is_expected.to validate_presence_of(:first_name) }
  # it { is_expected.to validate_presence_of(:last_name) }
end
