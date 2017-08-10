
class Invitation < ApplicationRecord
  validate :invitor_id_not_equal_user_to_invite, :uniq_invite, :uniq_user_invite
  belongs_to :invitor, class_name: 'User'
  belongs_to :user_to_invite, class_name: 'User'
  belongs_to :board
  def invitor_id_not_equal_user_to_invite
      if self.invitor_id == self.user_to_invite_id
        errors.add(:invitor_id, "can't be equal user ")
      end
  end
  def uniq_invite
    count_of_equal_invite = Invitation.where(board_id:self.board_id,user_to_invite_id: self.user_to_invite_id).count
    if count_of_equal_invite > 0
      errors.add(:invite, "must be uniq")
    end
  end
  def uniq_user_invite
    user_to_invite = User.find(self.user_to_invite_id)
    user_to_invite_boards = user_to_invite.boards
    if user_to_invite_boards.ids.include?(self.board_id)
      errors.add(:user_to_invite, "must be uniq")
    end
  end
end
