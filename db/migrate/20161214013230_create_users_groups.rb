class CreateUsersGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :users_groups do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      # 管理者であるかどうか。(true => 管理者である)
      t.boolean :admin, default: false, null: false

    end
    add_index :users_groups, [:user_id, :group_id], unique: true
  end
end
