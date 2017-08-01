class Profile < ApplicationRecord
  has_many :boards, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :disabled_lists, dependent: :destroy
  # has_many :disabled_lists, dependent: :destroy
  belongs_to :user
  #validates :first_name, :first_name, :birthdate, presence: true
  mount_uploader :photo_url, PhotoUploader
end
