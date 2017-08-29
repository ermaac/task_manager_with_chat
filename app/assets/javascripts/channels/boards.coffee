App.boards = App.cable.subscriptions.create channel: "BoardsChannel", room: getBoardId(),
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server
  destroy: (info) ->
    current_board_id = getBoardId()
    if parseInt(current_board_id) == info['id']
      window.location.replace(info['location'])

  kick_user: (info) ->
    $(".joined_users #user_#{info['id']}").remove()

  join_user: (info) ->
    id = getBoardId()
    $.ajax("/dashboards/#{id}/users/#{info['user_id']}/join_user")

  received: (data) ->
    action = data['action']
    info = data['info']
    App.boards[action](info)
    # Called when there's incoming data on the websocket for this channel

App.cable.subscriptions.create channel: "BoardsChannel", room: 0,
  received: (data) ->
    console.log data
    $("#board_#{data['id']}").remove()
