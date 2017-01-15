class CreateUsersTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :users_tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.datetime :finished_at
    end
    add_index :users_tasks, [:user_id, :task_id], unique: true
  end
end
