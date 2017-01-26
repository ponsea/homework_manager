class UsersTasksController < OnGroupsController
  layout 'group'

  def index
    key, type = (params[:order] || 'deadline_asc').split('_')

    users_tasks = UsersTask.group_is(@group).where(user: @user).order("tasks.#{key} #{type}")

    @unfinished_u_tasks = users_tasks.select {|ut| ut.state == UsersTask::STATE_UNFINISHED}
    @finished_u_tasks = users_tasks.select {|ut| ut.state == UsersTask::STATE_FINISHED}
    @confirmed_u_tasks = users_tasks.select {|ut| ut.state == UsersTask::STATE_CONFIRMED}
  end

  def show
    @users_task = UsersTask.find(params[:id])
  end

  def update
    users_task = UsersTask.find(params[:id])
    return unless users_task.user_id == @user.id

    case params[:state]
    when 'unfinished'
      users_task.state = UsersTask::STATE_UNFINISHED
      users_task.finished_at = nil
      users_task.save!
      redirect_to({action: :show}, notice: '未完了にしました。')
    when 'finished'
      users_task.state = UsersTask::STATE_FINISHED
      users_task.finished_at = Time.current
      users_task.save!
      redirect_to({action: :show}, notice: '完了にしました。')
    end
  end
end
