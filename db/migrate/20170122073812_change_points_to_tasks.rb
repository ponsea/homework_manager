class ChangePointsToTasks < ActiveRecord::Migration[5.0]
  def change
    change_column_default :tasks, :points, 0
  end
end
