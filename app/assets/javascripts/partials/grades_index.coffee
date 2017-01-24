onPageLoad 'grades#index', ->
  $('#add_grade_btn').click ->
    new_grade = $('#clone').clone(true).removeAttr('id')
    $('#grades_form').prepend(new_grade.hide().fadeIn())

  $('#save_btn').click ->
    $('#grades_form').submit()

  $('.remove_btn').click ->
    $(this).parent().fadeOut -> $(this).remove()
