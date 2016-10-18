class User < ApplicationRecord
  # emailからユーザの存在を確認し、passwordで認証を行う。
  # 認証に成功した場合は該当するUserオブジェクトを返す。
  # 失敗した場合はnilを返す。
  def self.authenticate(email, password)
    if user = find_by(email: email)
      digest = Digest::SHA256.hexdigest(password + user.salt)
      if digest == user.password
        return user
      end
    end
    return nil
  end
end
