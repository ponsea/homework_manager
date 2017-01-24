class Grade < ApplicationRecord
  belongs_to :group

  validates :necessary_points,
    inclusion: {
      in: 0..2_000_000_000,
    }
  validates :name,
    length: { maximum: 40 }
end
