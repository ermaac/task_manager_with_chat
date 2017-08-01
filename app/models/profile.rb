class Profile < ApplicationRecord
  belongs_to :user
  validates :first_name, :first_name, presence: true
end
