# frozen_string_literal: true

class Board < ApplicationRecord
  has_many :lists, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_one :chat, dependent: :destroy
  has_many :user_boards
  has_many :users, through: :user_boards, dependent: :destroy
  validates :title, :description, presence: true
end
