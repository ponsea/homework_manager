class User < ApplicationRecord
  has_many :users_groups
  has_many :joined_groups, through: :users_groups, class_name: 'Group', source: :group
  has_many :created_groups, class_name: 'Group', foreign_key: 'author_id'
  has_many :created_tasks, class_name: 'Task', foreign_key: 'author_id'
  has_many :tasks_profiles, class_name: 'UsersTask'
  has_many :tasks, through: :tasks_profiles, source: :task
  has_many :messages

  # 新規登録の時などにバリデーションを行うためのパスワードのフィールド
  # （実際のDBと関連付いたフィールド「password」はハッシュ値なので。）
  attr_accessor :validate_password

  # 登録前にvalidate_passwordからpassword(ハッシュ済)とsaltを設定する
  # コールバック（hash_password）の登録
  before_save :hash_password, if: Proc.new { |u| !u.validate_password.blank? }

  # *** バリデーション ***
  validates :name,
    presence: { message: '必須です' },
    length: { maximum: 30, allow_blank: true,
      message: 'ユーザーネームは30文字以内です' }
  validates :email,
    presence: { message: '必須です' },
    uniqueness: { message: '既に登録されたメールアドレスです' },
    format: { with: /\A[a-zA-Z0-9_\#!$%&`'*+\-{|}~^\/=?\.]+@[a-zA-Z0-9][a-zA-Z0-9\.-]+\z/,
      allow_blank: true,
      message: 'メールアドレスの形式に誤りがあります' }
  validates :validate_password,
    presence: { message: '必須です' },
    confirmation: { message: 'パスワード（確認用）と相違があります' },
    length: { within: 8..40, allow_blank: true, message: 'パスワード長は8文字以上です' }


  # emailからユーザの存在を確認し、passwordで認証を行う。
  # 認証に成功した場合は該当するUserオブジェクトを返す。
  # 失敗した場合はnilを返す。
  def self.authenticate(email, password)
    if user = find_by(email: email)
      if user.digest_of(password) == user.password
        return user
      end
    end
    return nil
  end

  # ユーザのパスワードをハッシュ化する前に付与する文字列を生成する
  # レインボーテーブル攻撃対策
  def self.generate_salt
    SecureRandom.hex(8)
  end

  # 文字列のハッシュ値を得る。
  # このクラスにかかわるハッシュ値の計算はこのメソッドに統一する
  def self.digest(str)
    Digest::SHA256.hexdigest(str)
  end

  # パスワードを受け取り自身のソルトと合わせたうえでのハッシュ値を返す
  def digest_of(password)
    User.digest(password + self.salt)
  end

  def points_with(group)
    UsersGroup.total_points_of(self, group)
  end

  def grade_with(group)
    Grade.grade_of(group, self.points_with(group))
  end

  private
  # validate_passwordに設定されたパスワードをソルト付きハッシュに
  # 変換してpasswordに設定する。同時にsaltも登録する
  # このメソッドはusersテーブルへの登録前に呼び出される。
  def hash_password
    self.salt = User.generate_salt
    self.password = self.digest_of(self.validate_password)
  end
end
