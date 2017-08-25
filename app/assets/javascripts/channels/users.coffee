App.users = App.cable.subscriptions.create channel: "UsersChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server
  leave_board: (info) ->
    $("##{info['id']}").remove()

  received: (data) ->
    action = data['action']
    info = data['info']
    App.users[action](info)
    # Called when there's incoming data on the websocket for this channel
