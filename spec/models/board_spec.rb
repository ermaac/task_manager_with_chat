require 'rails_helper'

RSpec.describe Board, type: :model do
  context 'Board' do

    it 'Board exists' do
      board = Board.new
      expect(board).to be_truthy
    end

    it 'Board can include some lists' do
      board = Board.new
      list = List.new
      list2 = List.new
      board.lists << list
      board.lists << list2
      expect(board.lists).to include(list,list2)
    end
  end
end
