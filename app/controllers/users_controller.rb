class UsersController < ApplicationController
  before_action :check_logined, except: [:new, :create]
  before_action :check_not_logined, only: [:new, :create]

  def new
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
  def users_params
    params.require(:user).permit(
      :email,
      :validate_password,
      :validate_password_confirmation,
      :name
    )
  end
end
