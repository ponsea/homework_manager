onPageLoad 'users_tasks#show', ->
  now_state = $('#state').data('state')
  $('#state').click ->
    return if now_state == 'confirmed'
    if now_state == 'unfinished'
      $('#hidden_state').val('finished')
    else
      $('#hidden_state').val('unfinished')
    $('#state_change_form').submit()
