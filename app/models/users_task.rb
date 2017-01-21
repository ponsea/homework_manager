class UsersTask < ApplicationRecord
  belongs_to :user
  belongs_to :task

  scope :group_is, -> (group) { joins(:task).where(tasks: {group: group}) }

  STATE_UNFINISHED = 0  # 未完了
  STATE_FINISHED = 1    # 完了
  STATE_CONFIRMED = 2   # 確認済
end
