# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('[data-toggle="popover"]').popover html: true

$ ->
  $('.actions_menu').each ->
    id = $(this).attr 'list'
    $.ajax(url: "/lists/#{id}/allowed_actions")
