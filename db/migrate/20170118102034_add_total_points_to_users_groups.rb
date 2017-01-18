class AddTotalPointsToUsersGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :users_groups, :total_points, :integer, null: false, default: 0
  end
end
