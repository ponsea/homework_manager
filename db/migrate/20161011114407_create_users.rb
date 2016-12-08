class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password, limit: 64, null: false
      t.string :salt, limit: 16, null: false
      t.string :name, limit: 30, null: false

      t.index :email, unique: true
    end
  end
end
