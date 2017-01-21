class UsersTasksController < OnGroupsController
  layout 'group'

  def index
    key, type = (params[:order] || 'deadline_asc').split('_')

    users_tasks = UsersTask.group_is(@group).where(user: @user).order("tasks.#{key} #{type}")

    @unfinished_u_tasks = users_tasks.select {|ut| ut.state == UsersTask::STATE_UNFINISHED}
    @finished_u_tasks = users_tasks.select {|ut| ut.state == UsersTask::STATE_FINISHED}
    @confirmed_u_tasks = users_tasks.select {|ut| ut.state == UsersTask::STATE_CONFIRMED}
  end
end
