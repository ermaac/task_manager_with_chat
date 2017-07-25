class Profile < ApplicationRecord
  belongs_to :User
  validates :first_name, :last_name, presence: true
  validates :first_name, :last_name, format: {with: /\A[A-Za-z][A-Za-z\-]+\z/, message: "allows only letters and dashes"}
  validate :valid_birthdate
  validate :valid_phone

  START_DATE = Date.new(1900, 1, 1)
  PHONE_REGEXP = /\A\+\d{8,20}\z/

  private
  def valid_birthdate
    return unless birthdate
    errors.add(:birthdate, "incorrect birthdate") if birthdate > Date.today || birthdate < START_DATE
  end

  def valid_phone
    return unless phone
    errors.add(:phone, "incorrect phone") unless phone =~ PHONE_REGEXP
  end
end
