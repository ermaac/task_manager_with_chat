class InvitedUserPermissionsController < ApplicationController

  def update
    @invited_user_permission = InvitedUserPermission.find_by(board_id: params[:board_id],
                                                             user_id: params[:user_id])
    if @invited_user_permission.update invited_user_permission_params
      ActionCable.server.broadcast "invited_user_permissions_channel_#{params[:board_id]}",
                                   permissions: params[:invited_user_permission],
                                   user_id: params[:user_id]
    else
      flash[:error] = 'Error updating permissions'
    end
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
