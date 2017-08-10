module DashboardsHelper
  def link_condition_first(user)
    if Board.find(params[:id]).creator_id == current_user.id && user.id != current_user.id
      link_to "Delete user", dashboard_path(user_id: user.id), method: :delete, class: "btn btn-danger"
    end
  end
  def link_condition_second(user)
    if UserBoard.where( board_id: params[:id], user_id: current_user.id ).count != 0 && user.id == current_user.id && Board.find(params[:id]).creator_id != current_user.id
      link_to "Leave board", dashboard_path(user_id: user.id), method: :delete, class: "btn btn-danger"
    end
  end
end
