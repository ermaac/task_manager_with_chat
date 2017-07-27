require 'rails_helper'

RSpec.describe Board, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_many(:lists).dependent(:destroy) }
  it { should have_many(:invitings).dependent(:destroy) }
  it { should have_one(:chat).dependent(:destroy) }
  it { should belong_to(:profile) }
end
