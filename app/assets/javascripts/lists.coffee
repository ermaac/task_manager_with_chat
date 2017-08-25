$ ->
  $('[data-toggle="popover"]').popover html: true

$ ->
  $('.actions_menu').each ->
    id = $(this).attr 'list'
    $.ajax(url: "/lists/#{id}/allowed_actions")
