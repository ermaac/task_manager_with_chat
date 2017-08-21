App.lists = App.cable.subscriptions.create "ListsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server
  request_allowed_actions: (id)->
    $.ajax(url: "/lists/#{id}/allowed_actions")

  create: (info) ->
    $('.lists-area').append info['list']
    $('#new_list_title').val ''
    @request_allowed_actions(info['id'])

  destroy: (info) ->
    list = $("#list_#{info['id']}")
    close_modal_button = $("#delete_list_#{info['id']} .close")
    close_modal_button.click()
    list.remove()

  update: (info) ->
    list_title = $("#list_#{info['list_id']} .list_title")
    list_title.html(info['title'])
    close_modal_button = $("#update_list_#{info['list_id']} .close")
    close_modal_button.click()

  switch_list_editability: (info) ->
    list = $("#list_#{info['id']} .col-md-3")
    list.replaceWith(info['list'])
    @request_allowed_actions(info['id'])

  received: (data) ->
    action = data['action']
    info = data['info']
    App.lists[action](info)
    # Called when there's incoming data on the websocket for this channel
