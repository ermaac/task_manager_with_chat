class InvitedUserPermissionsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "invited_user_permissions_channel_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
