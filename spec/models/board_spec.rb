# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Board, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to have_many(:lists).dependent(:destroy) }
  it { is_expected.to have_many(:invitations).dependent(:destroy) }
  it { is_expected.to have_one(:chat).dependent(:destroy) }
  it { is_expected.to have_many(:users).through(:user_boards).dependent(:destroy) }
end
