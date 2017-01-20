class AddStateToUsersTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :users_tasks, :state, :integer, limit: 1, null: false, default: 0
  end
end
