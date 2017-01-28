onPageLoad 'messages#index', ->
  $('#msg_form').on 'submit', ->
    return false unless $('#msg_body').val().match(/\S/)
