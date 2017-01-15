class Task < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :group
  has_many :subjects_profiles, class_name: 'UsersTask'
  has_many :subjects, class_name: 'User', through: :subjects_profiles, source: :user

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
