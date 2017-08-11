require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:messages).dependent(:destroy) }
  it { is_expected.to have_many(:boards).through(:user_boards).dependent(:destroy) }
  it { is_expected.to have_one(:profile).dependent(:destroy) }
  it { is_expected.to have_many(:invitors).class_name('Invitation') }
  it { is_expected.to have_many(:users_to_invite).class_name('Invitation') }
  it { is_expected.to have_many(:boards).through(:user_boards) }
end
