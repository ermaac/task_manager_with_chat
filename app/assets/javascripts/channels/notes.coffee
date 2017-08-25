App.notes = App.cable.subscriptions.create channel: "NotesChannel", room: getBoardId(),
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    list_id = '#list_' + data.list_id
    note_id = '#note_' + data.note_id
    unless data.action.blank?
      switch data.action
        when 'create'
          $("#{list_id} .list").append data.note
          $('textarea').val('')
        when "move"
          $("#{list_id} .list").append data.note
          list_id = '#list_' + data.current_note_list_id
          note_id = '#note_' + data.note_id
          $("#{list_id} #{note_id}").remove()
        when 'destroy' then $("#{list_id} #{note_id}").remove()
        when 'update' then $("#{note_id} p").text(data.note_text)
