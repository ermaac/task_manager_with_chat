class Inviting < ApplicationRecord
  belongs_to :invitor, class_name: User, foreign_key: :invitor_id

end
