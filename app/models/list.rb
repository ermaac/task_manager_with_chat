# frozen_string_literal: true

class List < ApplicationRecord
  has_many :notes, dependent: :destroy
  belongs_to :board
  validates :title, presence: true
end
