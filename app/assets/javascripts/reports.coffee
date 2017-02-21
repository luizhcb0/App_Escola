# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  @togglePanel = (element) ->
    $("#"+element.attr("class")).slideToggle(600)
    $("#"+element.attr("class")).css('display', "block")

  @selected = (element) ->
    $('#student_id').val(element.attr('id'))
    if !$(element).hasClass("selected")
      $(element).addClass('selected')
    else
      $(element).removeClass('selected')
    return

  # $('.std_link').click ->
  #   $('#student_id').val(this.id)
  #   if !$(this).hasClass("selected")
  #     $(this).addClass('selected')
  #   else
  #     $(this).removeClass('selected')
  #   # alert $('#student_id').val()
  # return
return
