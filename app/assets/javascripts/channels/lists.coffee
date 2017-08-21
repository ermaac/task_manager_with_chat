App.lists = App.cable.subscriptions.create "ListsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    id = '#list_' + data.list_id
    unless data.note.blank?
      $(id).append data.note
      $('textarea').val('')
