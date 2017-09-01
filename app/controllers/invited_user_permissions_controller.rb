class InvitedUserPermissionsController < ApplicationController

  def update
    @invited_user_permission = InvitedUserPermission.find_by(board_id: params[:board_id],
                                                             user_id: params[:user_id])
    @invited_user_permission.update(invited_user_permission_params)
    redirect_to dashboard_path(params[:board_id])
  end

  private

  def invited_user_permission_params
    params.require(:invited_user_permission).permit(:create_message,
                                                    :create_note,
                                                    :edit_note,
                                                    :delete_note,
                                                    :move_note_to_other_list,
                                                    :create_list,
                                                    :edit_list_name,
                                                    :delete_list,
                                                    :freeze_list)
  end
end
