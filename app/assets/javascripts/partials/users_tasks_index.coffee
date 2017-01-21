onPageLoad 'users_tasks#index', ->
  params = location.search.substring(1)
  if params
    params.match(/order=(.*?)($|&)/)
    $("#order_form option[value=#{RegExp.$1}]").prop('selected', true)

  $('#order_form > select[name="order"]').change ->
    $('#order_form').submit()
