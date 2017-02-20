# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $('.std_link').click ->
    $('#student_id').val(this.id)
    if !$(this).hasClass("selected")
      $(this).addClass('selected')
    else
      $(this).removeClass('selected')
    # alert $('#student_id').val()
  return
return
