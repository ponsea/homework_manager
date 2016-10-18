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
end
