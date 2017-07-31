require 'rails_helper'

RSpec.describe DisabledList, type: :model do
  it { should belong_to(:list) }
  it { should belong_to(:profile) }
end
