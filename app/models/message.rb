class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user, optional: true

  validates :body, presence: true
end
