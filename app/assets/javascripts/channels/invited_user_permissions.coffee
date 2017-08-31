App.invited_user_permissions = App.cable.subscriptions.create channel: "InvitedUserPermissionsChannel", room: getBoardId(),
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
