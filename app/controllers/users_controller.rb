class UsersController < ApplicationController
  before_action :check_logined, except: [:new, :create]
  before_action :check_not_logined, only: [:new, :create]

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

  def create
    @new_user = User.new(users_params)

    if @new_user.save
      reset_session
      session[:user_id] = @new_user.id
      @user = @new_user
    else
      render :new
    end
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

  def users_params
    params.require(:user).permit(
      :email,
      :validate_password,
      :validate_password_confirmation,
      :username
    )
  end
end
