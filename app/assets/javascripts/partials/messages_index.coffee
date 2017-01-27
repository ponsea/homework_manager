onPageLoad 'messages#index', ->
  console.log('aaa')
  $('#msg_form').on 'submit', ->
    return false unless $('#msg_body').val().match(/\S/)
