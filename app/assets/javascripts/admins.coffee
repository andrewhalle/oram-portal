# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@filter_by_status = (s) ->
  window.location.href = "/clients/?status=" + s
  return
  
@filter_by_phase = (p) ->
  window.location.href = "/clients/?phase=" + p
  return
