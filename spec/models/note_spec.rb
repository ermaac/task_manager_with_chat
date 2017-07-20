require 'rails_helper'

RSpec.describe Note, type: :model do
  context 'Note' do

    it 'Note exists' do
      note = Note.new
      expect(note).to be_truthy
    end
  end
end


