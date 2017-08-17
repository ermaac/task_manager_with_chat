class Profile < ApplicationRecord
  has_many :boards, dependent: :destroy
  has_many :messages, dependent: :destroy
  belongs_to :user
  validates :first_name, :last_name, :birthdate, :sex, presence: true, on: :update
  has_attached_file :photo_url, styles: { medium: "300x300>", thumb: "200x200>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo_url, content_type: /\Aimage\/.*\z/
  enum sex: [:male, :female]
end
