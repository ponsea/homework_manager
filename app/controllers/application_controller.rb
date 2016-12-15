class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  # ユーザがログイン状態なら当該Userオブジェクトを返す。そうでないならnilを返す
  # 不正なセッションを保持していた場合はリセットする
  def logined_user
    if session[:user_id]
      begin
        return User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound
        reset_session
      end
    end
    return nil
  end

  # ユーザがログイン状態でない場合はログイン画面にリダイレクトするフィルタ
  # ログイン状態の場合は@userに当該Userオブジェクトをセットする
  def check_logined
    unless @user = logined_user
      flash[:referer] = request.fullpath
      redirect_to controller: :top, action: :login
    end
  end

  # ユーザが既にログイン状態ならusers#showにリダイレクトするフィルタ
  def check_not_logined
    if logined_user
      redirect_to controller: :users, action: :show
    end
  end
end
