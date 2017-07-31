class Message < ApplicationRecord
  belongs_to :profile
  belongs_to :chat
  validates :text, presence: true
end
