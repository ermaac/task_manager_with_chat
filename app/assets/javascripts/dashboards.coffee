# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.scrollable').bind 'mousewheel', (e) ->
    e.preventDefault
$ ->
  if window.location.pathname.match /\/dashboards\/\d+/
    chat = $('.chat')
    height = chat[0].scrollHeight
    chat.scrollTop height
