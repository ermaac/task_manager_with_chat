class List < ApplicationRecord
  has_many :notes, dependent: :destroy
end
