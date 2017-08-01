# frozen_string_literal: true

class Board < ApplicationRecord
  has_many :lists, dependent: :destroy
  has_many :invitings, dependent: :destroy
  has_one :chat, dependent: :destroy
  belongs_to :user
  validates :title, :description, presence: true
end
