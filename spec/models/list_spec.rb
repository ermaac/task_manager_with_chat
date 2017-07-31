# frozen_string_literal: true

require 'rails_helper'

RSpec.describe List, type: :model do
  it { should validate_presence_of(:title) }
  it { should have_many(:notes).dependent(:destroy) }
  it { should have_many(:disabled_lists).dependent(:destroy) }
  it { should belong_to(:board) }
end
