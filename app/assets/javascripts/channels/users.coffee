App.users = App.cable.subscriptions.create channel: "UsersChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server
  leave_board: (info) ->
    location = window.location
    id = getBoardId()
    if location.pathname.match /\/|\/dashboards/
      $("#board_#{info['id']}").remove()
    if id == info['id']
      location.replace info['location']

  received: (data) ->
    action = data['action']
    info = data['info']
    App.users[action](info)
    # Called when there's incoming data on the websocket for this channel
