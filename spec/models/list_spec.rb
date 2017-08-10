# frozen_string_literal: true

require 'rails_helper'

RSpec.describe List, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to have_many(:notes).dependent(:destroy) }
  it { is_expected.to belong_to(:board) }
end
