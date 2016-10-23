class User < ApplicationRecord
  # 新規登録の時などにバリデーションを行うためのパスワードのフィールド
  # （実際のDBと関連付いたフィールド「password」はハッシュ値なので。）
  attr_accessor :validate_password

  before_save :hash_password, if: Proc.new { |u| !u.validate_password.blank? }

  validates :username,
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

  # パスワードを受け取り自身のソルトと合わせたうえでのハッシュ値を返す
  def digest_of(password)
    Digest::SHA256.hexdigest(password + self.salt)
  end

  private

  # saveメソッドの前にvalidate_passwordに設定されたpasswordを、
  # ソルト付きハッシュに変換してpasswordに設定する。同時にsaltも登録する
  def hash_password
    self.salt = User.generate_salt
    self.password = self.digest_of(self.validate_password)
  end
end
