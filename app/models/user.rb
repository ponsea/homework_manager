class User < ApplicationRecord
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
  def self.create_salt
    SecureRandom.hex(8)
  end

  # パスワードを受け取り自身のソルトと合わせたうえでのハッシュ値を返す
  def digest_of(password)
    Digest::SHA256.hexdigest(password + self.salt)
  end
end
