class TopController < ApplicationController
  before_action :check_not_logined

  def auth
    # 認証処理。成功した場合は当該Userオブジェクト。失敗した場合はnil
    user = User.authenticate(params[:email], params[:password])

    if user
      # 認証が成功した場合はセッションidを発行
      reset_session
      session[:user_id] = user.id
      if params[:referer].blank?
        # リダイレクトによるログインでない場合はusers#showへ
        redirect_to user_path
      else
        # リダイレクトによるログインの場合は元の場所へ。
        redirect_to params[:referer]
      end
    else
      # 認証が失敗した場合はリダイレクト元を引き継いでtop#loginへ
      flash[:referer] = params[:referer]
      flash[:email] = params[:email]
      redirect_to top_login_path, alert: "メールアドレスまたはパスワードが間違っています"
    end
  end
end
