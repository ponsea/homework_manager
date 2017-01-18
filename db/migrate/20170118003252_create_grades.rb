class CreateGrades < ActiveRecord::Migration[5.0]
  def change
    create_table :grades do |t|
      t.string :name, limit: 40, null: false
      t.references :group, foreign_key: true, null: false
      t.integer :necessary_points, null: false
      t.timestamps
    end
    add_index :grades, [:group_id, :necessary_points], unique: true
  end
end
