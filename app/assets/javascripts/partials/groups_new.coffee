onPageLoad ['groups#new', 'groups#create'], ->
  # パスワードを設定するか否かのチェックボックスが変更されたら
  $('#group_private').on 'change', ->
    if $(this).prop 'checked' # チェックボックスにチェックがある場合
      # パスワード入力フィールドを有効にする
      $('#group_password, #group_password_confirmation').prop('disabled', false)
    else
      # パスワードの入力フィールドを無効にする
      $('#group_password, #group_password_confirmation').prop('disabled', true)
