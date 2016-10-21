class UsersController < ApplicationController
  before_action :check_logined, except: :new

  def show
    @title = "ホーム"
  end

  private
  # ユーザがログイン状態でない場合はログイン画面にリダイレクトするフィルタ
  # ログイン状態の場合は@userに当該Userオブジェクトをセットする
  def check_logined
    unless @user = logined_user
      flash[:referer] = request.fullpath
      redirect_to controller: :top, action: :login
    end
  end
end
