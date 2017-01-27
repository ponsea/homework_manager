class UsersTasksController < OnGroupsController
  layout 'group'
  before_action :check_admin, only: :confirm

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

  def confirm
    users_tasks = UsersTask.where(id: params[:users_tasks])
    UsersTask.transaction do
      users_tasks.each do |ut|
        ut.state = UsersTask::STATE_CONFIRMED
        UsersGroup.where(group: @group).where(user: ut.user).first
            .increment!(:total_points, ut.task.points)
        ut.save!
      end
    end
    redirect_to controller: :tasks, action: :show, id: params[:task]
  end
end
