module DashboardsHelper
  def link_for_creator(user)
    if Board.find(params[:id]).creator_id == current_user.id && user.id != current_user.id
      link_to "Delete user", dashboard_path(user_id: user.id), method: :delete, class: "btn btn-danger"
    end
  end

  def link_for_subscriber(user)
    if UserBoard.where( board_id: params[:id], user_id: current_user.id ).count != 0 && user.id == current_user.id && Board.find(params[:id]).creator_id != current_user.id
      link_to "Leave board", dashboard_path(user_id: user.id), method: :delete, class: "btn btn-danger"
    end
  end

  def board_creator?(user)
    user.id == current_user.id && @board.creator_id != user.id
  end

  def board_subscriber?(user)
    @board.creator_id == user.id
  end

  def make_nickname message
    profile = message.user.profile
    "#{profile.last_name} #{profile.first_name[0]}.".titleize
  end
end
