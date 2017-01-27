class MessagesController < OnGroupsController
  layout 'group'

  def index
    @messages = Message.where(group: @group)
                .page(params[:page])
                .order(created_at: :desc)
  end
  def create
    Message.create!(body: params[:body], user: @user, group: @group)
    redirect_to action: :index
  end
end
