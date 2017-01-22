class TasksController < OnGroupsController
  layout 'group'
  before_action :check_admin

  def index
    @tasks = Task.where(group: @group).order(updated_at: :desc)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(tasks_params)
    if @task.save
      # TODO: メール送信処理

      redirect_to action: :index
    else
      render :new
    end
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
