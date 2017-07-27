class Inviting < ApplicationRecord
  belongs_to :invitor, class_name: 'User'
  belongs_to :user_to_invite, class_name: 'User'
  belongs_to :board
end
