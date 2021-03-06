class GroupsController < OnGroupsController
  skip_before_action :check_joined, except: [:show, :edit, :update, :destroy]
  layout 'group', only: [:show, :edit]

  def index
    # 参加しているグループとその作成者をあらかじめ読み込む。(n+1問題対策)
    @user = User.includes(joined_groups: :author).find(@user.id)
  end

  def show
  end

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
    return render :new unless @new_group.valid?

    # 作成したグループをDBに反映する。同時に、作成者をそのグループのメンバーとする
    Group.transaction do
      @new_group.save! validate: false
      UsersGroup.create!(user: @new_group.author, group: @new_group, admin: true)
      @new_group.messages.create!(body: "「#{@new_group.name}」が結成されました。")
    end
  end

  def search
    case params[:search_type]
    when 'id' then
      where_args = [ { id: params[:input_text] } ]
    when 'keyword' then
      keyword = "%#{params[:input_text]}%"
      # HACK: Arel API使うべき?
      where_args = [ 'name LIKE ? OR detail LIKE ?', keyword, keyword ]
    else # 指定されていない。又は不正な値
      return
    end

    # 最大10件ごとにページネーションするように取得
    @groups = Group.includes(:author).where(*where_args)
                .page(params[:page])
                .per(10)
                .order(:id)
  end

  def reception
    @group = Group.find(params[:id])
    # 当該グループに、既に参加していた場合はshowにリダイレクト
    redirect_to group_path(@group) if @group.members.exists?(@user)
  end

  def join
    @group = Group.find(params[:id])
    if @group.password == params[:password]
      UsersGroup.create!(user: @user, group: @group, admin: false)
    else
      @alert = 'パスワードが間違っています。'
      render :reception
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
