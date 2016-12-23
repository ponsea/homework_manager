class GroupsController < ApplicationController
  before_action :check_logined

  def new
    @new_group = Group.new
  end

  def create
    #ユーザが入力した値を取得
    params = groups_params
    # グループの作成者を設定（ログインユーザ）
    params.store :author, logined_user
    # グループオブジェクト作成
    @new_group = Group.new(params)

    # ユーザの入力に誤りがあった場合は作成ページに戻る
    unless @new_group.valid?
      render :new
      return
    end

    # 作成したグループをDBに反映する。同時に、作成者をそのグループのメンバーとする
    Group.transaction do
      @new_group.save! validate: false
      UsersGroup.create!(user: @new_group.author, group: @new_group, admin: true)
    end
  end

  private
  def groups_params
    params.require(:group).permit(
      :name,
      :detail,
      :private,
      :password,
      :password_confirmation
    )
  end
end
