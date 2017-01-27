class Group < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :users_groups, -> {order(total_points: :desc)}
  has_many :members, through: :users_groups, class_name: 'User', source: :user
  has_many :admins, -> { where(users_groups: {admin: true}) }, through: :users_groups, class_name: 'User', source: :user
  has_many :not_admins, -> { where(users_groups: {admin: false}) }, through: :users_groups, class_name: 'User', source: :user
  has_many :tasks
  has_many :messages, -> {order(created_at: :desc)}
  has_many :grades, -> {order(necessary_points: :desc)}, dependent: :destroy

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
