require 'rails_helper'

RSpec.describe Invitation, type: :model do
  it { is_expected.to belong_to(:board) }
  it { is_expected.to validate_uniqueness_of(:board_id) }
  it { is_expected.to belong_to(:invitor).class_name('User') }
  it { is_expected.to belong_to(:user_to_invite).class_name('User') }
end
