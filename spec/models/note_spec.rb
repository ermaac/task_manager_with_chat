require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Note, type: :model do
  let(:valid_note)   { build(:note) }
  let(:invalid_note) { build(:note, title: '') }

  describe 'presence validation' do
    it 'does not passes validation' do
      invalid_note.valid?
      expect(invalid_note.errors[:title]).to include("can't be blank")
    end

    it 'passes validation' do
      valid_note.valid?
      expect(valid_note.errors[:title]).to_not include("can't be blank")
    end
  end
end
