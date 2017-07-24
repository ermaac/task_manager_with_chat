require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Board, type: :model do
  let(:valid_board)   { build(:board) }
  let(:invalid_board) { build(:board, title: '') }

  describe 'presence validation' do
    it 'does not passes validation' do
      invalid_board.valid?
      expect(invalid_board.errors[:title]).to include("can't be blank")
    end

    it 'passes validation' do
      valid_board.valid?
      expect(valid_board.errors[:title]).to_not include("can't be blank")
    end
  end

  describe 'assotiation' do
    let(:list1) { build(:list) }
    let(:list2) { build(:list) }
    let(:board) { build(:board, lists: lists) }
    let(:lists) { [list1, list2] }

    it 'includes some lists' do
      expect(board.lists).to include(list1, list2)
    end
  end
end
