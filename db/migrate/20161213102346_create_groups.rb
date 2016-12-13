class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :name, limit: 40, null: false
      t.text :detail
      t.boolean :private, default: false, null: false
      t.string :password, limit: 40
      t.references :author, null: false
      t.timestamps
    end
    add_foreign_key :groups, :users, column: :author_id
  end
end
