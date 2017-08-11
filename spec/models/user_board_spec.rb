require 'rails_helper'

RSpec.describe UserBoard, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:board) }
end
