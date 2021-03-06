class TasksController < OnGroupsController
  layout 'group'
  before_action :check_admin

  def index
    @tasks = Task.where(group: @group)
                .page(params[:page])
                .per(10)
                .order(updated_at: :desc)
  end

  def show
    @task = Task.includes(:users).find(params[:id])
    @finished_u_tasks = @task.users_tasks.select{|ut| ut.state == UsersTask::STATE_FINISHED}
    @unfinished_u_tasks = @task.users_tasks.select{|ut| ut.state == UsersTask::STATE_UNFINISHED}
    @confirmed_u_tasks = @task.users_tasks.select{|ut| ut.state == UsersTask::STATE_CONFIRMED}
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(tasks_params)
    return render :new unless @task.valid?

    Task.transaction do
      @task.save!
      @group.not_admins.each do |m|
        m.tasks << @task
      end
      @group.messages.create!(body: "新タスク「#{@task.title}」が生成されました")
    end
    if params[:mail]
      to = @group.members.map {|m| m.email }
      NoticeMailer.task_created(@task, to).deliver
    end
    redirect_to action: :index
  end

  private

  def tasks_params
    params.require(:task).permit(
      :title,
      :detail,
      :deadline,
      :importance,
      :points
    ).merge(group: @group, author: @user)
  end
end
