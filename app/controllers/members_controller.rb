class MembersController < OnGroupsController
  layout 'group'
  before_action :check_admin, only: :addmin

  def addmin
    ug = @group.users_groups.where(user_id: params[:user_id]).first
    ug.admin = true
    ug.save!
    redirect_to({action: :index}, notice: "#{ug.user.name}さんを管理者にしました。")
  end
end
