class Profile < ApplicationRecord
  has_many :boards, dependent: :destroy
  has_many :messages, dependent: :destroy
  belongs_to :user
  validates :first_name, :last_name, :birthdate, :sex, presence: true, on: :update
  mount_uploader :photo_url, PhotoUploader
  enum sex: [:male, :female]
end
