class TasksController < OnGroupsController
  layout 'group'
  before_action :check_admin

  def index
    @tasks = Task.where(group: @group).order(updated_at: :desc)
  end
end
