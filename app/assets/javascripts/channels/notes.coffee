App.notes = App.cable.subscriptions.create "NotesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    list_id = '#list_' + data.list_id
    note_id = '#note_' + data.note_id
    edit_modal_id = '#edit_notes_' + data.note_id
    delete_modal_id = '#delete_' + data.note_id
    move_modal_id = '#move_note_' + data.note_id
    unless data.action.blank?
      switch data.action
        when 'create'
          $("#{list_id} .list").append data.note
          $('textarea').val('')
        when "move"
          $("#{list_id} .list").append data.note
          current_list_id = '#list_' + data.current_note_list_id
          $("#{current_list_id} #{note_id}").remove()
          $("#{current_list_id} #{edit_modal_id}").remove()
          $("#{current_list_id} #{move_modal_id}").remove()
          $("#{current_list_id} #{delete_modal_id}").remove()
        when 'destroy'
          $("#{list_id} #{note_id}").remove()
          $("#{list_id} #{edit_modal_id}").remove()
          $("#{list_id} #{move_modal_id}").remove()
          $("#{list_id} #{delete_modal_id}").remove()
        when 'update' then $("#{note_id} p").text(data.note_text)
