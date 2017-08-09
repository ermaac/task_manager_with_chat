class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  validates :text, presence: true
  after_create_commit { BroadcastMessageJob.perform_later self }
end
