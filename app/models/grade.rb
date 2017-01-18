class Grade < ApplicationRecord
  belongs_to :group
  scope :grade_of, -> (group, points) {
    where(group: group)
      .where('necessary_points <= ?', points)
        .order(:necessary_points)
          .last
  }
end
