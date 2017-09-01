App.invited_user_permissions = App.cable.subscriptions.create channel: "InvitedUserPermissionsChannel", room: getBoardId(),
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    #$("div[id^='list_'] .pull-right .list_actions_menu").each(function( i, val ) {

    kek_id = $("div[id^='list_']")
    note_id = $(".scrollable .note").attr('id')

    if data.permissions['create_message'] == '0'
      $("#btn-input_chat-board_id_#{getBoardId()}_user_id_#{data.user_id}").remove()

    if data.permissions['create_message'] == '1'
      if $('.panel-footer .input-sm').val() == undefined
        $('.panel-footer').append("<input class='form-control input-sm' data-behavior='room_speaker' id='btn-input_chat-board_id_#{getBoardId()}_user_id_#{data.user_id}' type='text'>")
    #######################################

    if data.permissions['create_note'] == '0'
      $("#create_list_board_id_#{getBoardId()}_user_id_#{data.user_id} .form-group .btn-success").remove()

    if data.permissions['create_note'] == '1'
      if $("#create_list_board_id_#{getBoardId()}_user_id_#{data.user_id} .form-group .btn-success").val() == undefined
        $("#create_list_board_id_#{getBoardId()}_user_id_#{data.user_id} .form-group").append '<input type="submit" name="commit" value="Create Note" class="btn btn-success btn-block" data-disable-with="Create Note">'

    #######################################

    if data.permissions['delete_list'] == '0'
      $.each $('div[id^=\'list_\'] .list_actions_menu[id^=\'list_\']'), (i, val) ->
        $("#destroy_list_board_id_#{getBoardId()}_user_id_#{data.user_id}").remove()
        return

    if data.permissions['delete_list'] == '1'
      $.each $('div[id^=\'list_\'] .list_actions_menu[id^=\'list_\']'), (i, val) ->
        if $(".list_actions_menu .fa-times").val() == undefined
          $.each $("div[id^='list_'] .pull-right .list_actions_menu"), (j, value) ->
            list_id = $(value).attr('id');
            $(".list_actions_menu").prepend("<li id='destroy_list_board_id_#{getBoardId()}_user_id_#{data.user_id}'><a data-toggle='modal' href='#delete_#{list_id}'><div class='fa fa-times'></div></a></li>")
            return

    #######################################

    if data.permissions['edit_list_name'] == '0'
      $.each $('div[id^=\'list_\'] .list_actions_menu[id^=\'list_\']'), (i, val) ->
        $("#update_list_board_id_#{getBoardId()}_user_id_#{data.user_id}").remove()
        return

    if data.permissions['edit_list_name'] == '1'
      $.each $('div[id^=\'list_\'] .list_actions_menu[id^=\'list_\']'), (i, val) ->
        if $(".list_actions_menu .fa-pencil").val() == undefined
          $.each $("div[id^='list_'] .pull-right .list_actions_menu"), (j, value) ->
            list_id = $(value).attr('id');
            $("##{list_id} #destroy_list_board_id_#{getBoardId()}_user_id_#{data.user_id}").after("<li id='update_list_board_id_#{getBoardId()}_user_id_#{data.user_id}'><a data-toggle='modal' href='#update_#{list_id}'><div class='fa fa-pencil'></div></a></li>")
            return

    #######################################

    if data.permissions['freeze_list'] == '0'
      $.each $('div[id^=\'list_\'] .list_actions_menu[id^=\'list_\']'), (i, val) ->
        $("#switch_list_board_id_#{getBoardId()}_user_id_#{data.user_id}").remove()
        return

    if data.permissions['freeze_list'] == '1'
      $.each $('div[id^=\'list_\'] .list_actions_menu[id^=\'list_\']'), (i, val) ->
        if $(".list_actions_menu .fa-ban").val() == undefined
          $.each $("div[id^='list_'] .pull-right .list_actions_menu"), (j, value) ->
            list_id = $(value).attr('id');
            $("##{list_id} #update_list_board_id_#{getBoardId()}_user_id_#{data.user_id}").after("<li id='switch_list_board_id_#{getBoardId()}_user_id_#{data.user_id}'><a data-remote='true' rel='nofollow' data-method='put' href='/boards/#{getBoardId()}/lists/#{list_id.match(/\d+/)}/switch_editability'><div class='fa fa-ban'></div></a></li>")
            return


    #######################################

    if data.permissions['delete_note'] == '0'
      $.each $('div[id^=\'list_\'] #note_menu'), (i, val) ->
        $("#destroy_note_board_id_#{getBoardId()}_user_id_#{data.user_id}").remove()


    if data.permissions['delete_note'] == '1'
      $.each $("div[id^=\'list_\'] #note_menu"), (i, val) ->
        #if $("#note_menu .fa-times").val() == undefined
        $(val).prepend("<li id='destroy_note_board_id_#{getBoardId()}_user_id_#{data.user_id}'><a data-toggle='modal' title='delete note' href='#delete_#{note_id}'><div class='fa fa-times'></div></a></li>")
        return
    #######################################

    if data.permissions['edit_note'] == '0'
      $.each $('div[id^=\'list_\'] #note_menu'), (i, val) ->
        $("#edit_note_board_id_#{getBoardId()}_user_id_#{data.user_id}").remove()

    if data.permissions['edit_note'] == '1'
      $.each $('div[id^=\'list_\'] #note_menu'), (i, val) ->
        #if $("#note_menu .fa-pencil").val() == undefined
        $("#destroy_note_board_id_#{getBoardId()}_user_id_#{data.user_id}").after("<li id='edit_note_board_id_#{getBoardId()}_user_id_#{data.user_id}'><a data-toggle='modal' title='edit note' href='#edit_#{note_id}'><div class='fa fa-pencil'></div></a></li>")
        return
    #######################################

    if data.permissions['move_note_to_other_list'] == '0'
      $.each $('div[id^=\'list_\'] #note_menu'), (i, val) ->
        $("#move_note_board_id_#{getBoardId()}_user_id_#{data.user_id}").remove()

    if data.permissions['move_note_to_other_list'] == '1'
      $.each $('div[id^=\'list_\'] #note_menu'), (i, val) ->
      #if $("#move_note_board_id_#{getBoardId()}_user_id_#{data.user_id}").val() == undefined
        $("#edit_note_board_id_#{getBoardId()}_user_id_#{data.user_id}").after("<li id='edit_note_board_id_#{getBoardId()}_user_id_#{data.user_id}'><a data-toggle='modal' title='move note' href='#move_#{note_id}'><div class='fa fa-location-arrow'></div></a></li>")
        return
    #######################################

    if data.permissions['create_list'] == '0'
      $("#new_list_form #create-list_bord_id_#{getBoardId()}_user_id_#{data.user_id}").remove()

    if data.permissions['create_list'] == '1'
      if $("#new_list_form .btn-block").val() == undefined
        $("#new_list_form #new_list .form-group").append "<input type='submit' name='commit' value='Create List' class='btn btn-success btn-block' id='create-list_bord_id_#{getBoardId()}_user_id_#{data.user_id}' data-disable-with='Create List'>"



#<input class="form-control input-sm" data-behavior="room_speaker" id="btn-input_chat-board_id_7_user_id_2" type="text">
