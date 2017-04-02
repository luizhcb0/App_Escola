# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $prevSelected = null # previous selected kid
  @togglePanel = (element) ->
    $("#"+element.attr("class")).slideToggle(300)
    $("#"+element.attr("class")).css('display', "block")


  $(".alert").fadeOut(3000)

  $('#render_msg').click ->
    $(".right_forms .categories").css('display','none')
    $(".right_forms .messages").css('display','block')

  $('#render_cat').click ->
    $(".right_forms .messages").css('display','none')
    $(".right_forms .categories").css('display','block')

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


  $('input[type="checkbox"][name="student_ids[]"]').change ->
    if (this.checked)
      $(".message_form #"+this.value).val(this.value)
    else
      $(".message_form #"+this.value).val("")
      $('#select_all').attr('checked', false);
      return




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
