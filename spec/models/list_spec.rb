require 'rails_helper'
require 'support/factory_girl'

RSpec.describe List, type: :model do
  context 'title' do
    it 'should validate presence' do
      list = build(:list)
      list.title = ''
      list.valid?
      list.errors[:title].should include("can't be blank")
    end
    it 'should not validate presence' do
      list = build(:list)
      list.valid?
      list.errors[:title].should_not include("can't be blank")
    end
  end

  context 'assotiation' do
    it 'should include some notes' do
      list = build(:list)
      note1 = build(:note)
      note2 = build(:note)
      list.notes << note1
      list.notes << note2
      expect(list.notes).to include(note1,note2)
    end
  end
end
