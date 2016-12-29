onPageLoad 'groups#search', ->
  $('input:radio[name=search_type]').change ->
    if $(this).val() == 'keyword'
      $('input[name=input_text]').attr 'placeholder', 'キーワードを入力'
    else
      $('input[name=input_text]').attr 'placeholder', 'グループIDを入力'
