class Chat < ApplicationRecord
  has_many :message, dependent: :destroy
  belongs_to :board
end
