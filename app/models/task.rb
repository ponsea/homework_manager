class Task < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :group
  has_many :users_tasks
  has_many :users, through: :users_tasks

  # *** バリデーション ***
  validates :title,
    presence: { message: '必須です'},
    length: { maximum: 120, message: 'タイトルは120文字以内です'}
  validates :points,
    inclusion: {
      in: 0..30000,
      allow_nil: true
    }
  validates :importance,
    inclusion: {
      in: 1..10,
    }
end
