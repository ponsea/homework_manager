class UsersGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group
  scope :total_points_of, ->(user, group) {
    where(user: user).where(group: group)[0].total_points
  }
end
