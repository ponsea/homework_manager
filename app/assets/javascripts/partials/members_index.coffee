onPageLoad 'members#index', ->
  $('.addmin_btn').click ->
    $('#hidden_addmin').val($(this).data('id'))
    $('#addmin_form').submit()
