class Ability
  include CanCan::Ability
  attr_accessor :user

  def initialize(user)
    user ||= User.new(role: 2)

    if user.admin?
      admin_abilities(user)
    elsif user.user?
      user_abilities(user)
    else
      guest_abilities
    end
  end

  def guest_abilities
    can [:users], :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities(user)
    guest_abilities
    can :index, [:dashboard, Invitation]
    can :show, [:dashboard, Profile]
    can :create, [Board, Invitation, :dashboard]
    can :update, [Profile]
    can :destroy, [Board, Invitation]

    can :switch_editability, List if $board_id.invited_user_permissions.find_by(user_id: user.id).freeze_list?
    can :destroy, List if $board_id.invited_user_permissions.find_by(user_id: user.id).delete_list?
    can :update, List if $board_id.invited_user_permissions.find_by(user_id: user.id).edit_list_name?
    can :create, List if $board_id.invited_user_permissions.find_by(user_id: user.id).create_list?

    can :create, Note if $board_id.invited_user_permissions.find_by(user_id: user.id).create_note?
    can :update, Note if $board_id.invited_user_permissions.find_by(user_id: user.id).edit_note?
    can :destroy, Note if $board_id.invited_user_permissions.find_by(user_id: user.id).delete_note?
    can :move, Note if $board_id.invited_user_permissions.find_by(user_id: user.id).move_note_to_other_list?
    can :update_drop, Note

    can :notificate, Invitation

    can :create_message, Board do |board|
      board.invited_user_permissions.find_by(user_id: user.id).create_message?
    end
  end
end
