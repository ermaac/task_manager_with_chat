App.invited_user_permissions = App.cable.subscriptions.create channel: "InvitedUserPermissionsChannel", room: getBoardId(),
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data.permissions['create_message'] == '0'
      $("#chat_row_user_id_#{data.user_id}_bord_id_#{getBoardId()}").remove()

    if data.permissions['create_message'] == '1'
      $("#board_id_#{getBoardId()} .row").append '<input class="form-control input-sm" data-behavior="room_speaker" id="btn-input" type="text">/</input>
'

