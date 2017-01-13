class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title, limit: 120, null: false
      t.text :detail
      t.datetime :deadline
      t.integer :points, limit: 2
      t.integer :importance, limit: 1, default: 3, null: false
      t.references :author, null: false
      t.references :group, null: false
      t.timestamps
    end
    add_foreign_key :tasks, :users, column: :author_id
    add_foreign_key :tasks, :groups, column: :group_id
  end
end
