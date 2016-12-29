class Group < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :members, join_table: :users_groups, class_name: 'User'
  has_and_belongs_to_many :admins, -> { where(users_groups: {admin: true}) }, join_table: :users_groups, class_name: 'User'

  # *** バリデーション ***
  validates :name,
    presence: { message: '必須です' },
    length: { maximum: 40, allow_blank: true,
      message: 'グループ名は40文字以内です' }
  validates :password,
    presence: { message: '必須です', if: 'private' },
    confirmation: { message: 'パスワード（確認用）と相違があります' },
    length: { within: 8..40, allow_blank: true, message: 'パスワード長は8文字以上です' }
end
