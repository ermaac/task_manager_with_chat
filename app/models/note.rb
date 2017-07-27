# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :list
  validates :title, presence: true
end
