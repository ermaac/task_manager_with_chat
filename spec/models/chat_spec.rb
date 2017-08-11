require 'rails_helper'

RSpec.describe Chat, type: :model do
  it { is_expected.to belong_to(:board) }
  it { is_expected.to have_many(:messages).dependent(:destroy) }
end
