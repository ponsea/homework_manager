class OnGroupsController < ApplicationController
  before_action :check_logined
  before_action :check_joined

  private
  # 当該グループに参加していなかった場合は、
  # 参加確認ページにリダイレクトするフィルタ
  def check_joined
    @group = Group.find(params[:group_id] || params[:id])
    unless @group.members.exists?(@user.id)
      redirect_to reception_group_path(@group)
    end
  end

  def check_admin
    unless @group.admins.exists?(@user.id)
      redirect_to group_path(@group)
    end
  end
end
