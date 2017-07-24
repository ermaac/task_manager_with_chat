require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Note, type: :model do
  context 'title' do
    it 'should validate presence' do
      note = build(:note)
      note.title = ''
      note.valid?
      note.errors[:title].should include("can't be blank")
    end
    it 'should not validate presence' do
      note = build(:note)
      note.valid?
      note.errors[:title].should_not include("can't be blank")
    end
  end
end
