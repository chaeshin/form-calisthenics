class CreateWorkouts < ActiveRecord::Migration[7.1]
  def change
    create_table :workouts do |t|
      t.string :name
      t.string :category
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
