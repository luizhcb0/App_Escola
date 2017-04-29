# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->

  @togglePanel = (element) ->
    $("#"+element.attr("class")).slideToggle(300)
    $("#"+element.attr("class")).css('display', "block")

  $(".alert").fadeOut(3000)

  # Display messages partial
  $('#render_msg').click ->
    $(".right_forms .categories").css('display','none')
    $(".right_forms .messages").css('display','block')

  # Display categories partial
  $('#render_cat').click ->
    $(".right_forms .messages").css('display','none')
    $(".right_forms .categories").css('display','block')

  #  Select all students
  $("#select_all").click ->
    if(this.checked)
      $('input[type="checkbox"][name="student_ids[]"]').each ->
        this.checked = true
        $(".message_form #"+this.value).val(this.value)
        return
    else
      $('input[type="checkbox"][name="student_ids[]"]').each ->
        this.checked = false
        $(".message_form #"+this.value).val("")
        return
      return

  # Selected students for reports will be selected for messages and clips
  $('input[type="checkbox"][name="student_ids[]"]').change ->
    if (this.checked)
      $(".message_form #"+this.value).val(this.value)
      $("#clip-student"+this.value).val(this.value)
    else
      $(".message_form #"+this.value).val("")
      $("#clip-student"+this.value).val("")
      # removes the check from 'select_all' check box
      $('#select_all').attr('checked', false);
      return


  $("a#read-check").one("ajax:success", (e, data, status, xhr) ->
    $(this).parents("div.panel").fadeOut(2000)
    $("span.badge").text($("span.badge").text()-1)
    if $("span.badge").text() is "0"
      $("ul.nav").fadeOut(500)
  ).on "ajax:error", (e, xhr, status, error) ->
    $(this).after "<p style='color:red;'>An error occured, please try again later.</p>"

  # Resets the form after the modal is closed
  $('.modal').on('hidden.bs.modal', () ->
    $('form')[0].reset()
  )

  $(".absence").click ->
    $id = $(this).attr('id').replace('absence_','')
    $.ajax '/set_presence/'+$id+'/true',
        type: 'PATCH'
        success: ->
          # alert("oi")

  $(".presence").click ->
    $id = $(this).attr('id').replace('presence_','')
    $.ajax '/set_presence/'+$id+'/false',
        type: 'PATCH'
        success: ->
          # alert("oi")

# NOT USED ANYMORE DUE MULTIPE SELECTION
  # @selected = (element) ->
  #   $('#student_id').val(element.attr('id'))
  #   if !$(element).hasClass("selected")
  #     #  remove selected from previous kid
  #     $prevSelected.removeClass('selected') if $prevSelected isnt null
  #     $prevSelected = element
  #     $(element).addClass('selected')
  #   else
  #     $(element).removeClass('selected')
  #     #  remove selected from previous kid
  #     $prevSelected = null # resets the previous selected
  #   return

# ATERNATIVE TO THE FUNCTION ABOVE
  # $('.std_link').click ->
  #   $('#student_id').val(this.id)
  #   if !$(this).hasClass("selected")
  #     $(this).addClass('selected')
  #   else
  #     $(this).removeClass('selected')
  #   # alert $('#student_id').val()
  # return
return
