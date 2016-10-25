class UsersController < ApplicationController
  before_action :check_logined, except: :new
  before_action :check_not_logined, only: :new

  def show
    @title = "ホーム"
  end

  def edit
    @title = "ユーザ設定"
  end

  def new
    @title = "新規登録"
    @new_user = User.new
  end

  def logout
    reset_session
    redirect_to root_path
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
