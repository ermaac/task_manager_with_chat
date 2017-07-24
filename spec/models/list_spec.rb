require 'rails_helper'
require 'support/factory_girl'

RSpec.describe List, type: :model do
  let(:valid_list)   { build(:list) }
  let(:invalid_list) { build(:list, title: '') }

  describe 'presence validation' do
    it 'does not passes validation' do
      invalid_list.valid?
      expect(invalid_list.errors[:title]).to include("can't be blank")
    end
    it 'passes validation' do
      valid_list.valid?
      expect(valid_list.errors[:title]).to_not include("can't be blank")
    end
  end

  describe 'assotiation' do
    let(:note1) { build(:note) }
    let(:note2) { build(:note) }
    let(:list) { build(:list, notes: notes) }
    let(:notes) { [note1, note2] }

    it 'includes some lists' do
      expect(list.notes).to include(note1, note2)
    end
  end
end
