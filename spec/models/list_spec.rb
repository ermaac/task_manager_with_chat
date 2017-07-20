require 'rails_helper'

RSpec.describe List, type: :model do
  context 'List' do

    it 'List exists' do
      list = List.new
      expect(list).to be_truthy
    end

    it 'List can include some notes' do
      list = List.new
      note = Note.new
      note2 = Note.new
      list.notes << note
      list.notes << note2
      expect(list.notes).to include(note,note2)
    end
  end
end
