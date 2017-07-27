class List < ApplicationRecord
  has_many :notes, dependent: :destroy
  has_many :disabled_lists, dependent: :destroy
  # has_many :disabled_lists, dependent: :destroy
  belongs_to :board
  validates :title, presence: true
end
