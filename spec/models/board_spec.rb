require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Board, type: :model do
  context 'title' do
    it 'should validate presence' do
      board = build(:board)
      board.title = ''
      board.valid?
      board.errors[:title].should include("can't be blank")
    end
    it 'should not validate presence' do
      board = build(:board)
      board.valid?
      board.errors[:title].should_not include("can't be blank")
    end
  end

  context 'assotiation' do
    it 'should include some lists' do
      board = build(:board)
      list1 = build(:list)
      list2 = build(:list)
      board.lists << list1
      board.lists << list2
      expect(board.lists).to include(list1,list2)
    end
  end
end
