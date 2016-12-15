class Group < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :members, join_table: :users_groups, class_name: 'User'
  has_and_belongs_to_many :admins, -> {where ['users_groups.admin = ?', true]}, join_table: :users_groups, class_name: 'User'
end
