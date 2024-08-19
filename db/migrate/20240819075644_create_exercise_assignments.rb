class CreateExerciseAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :exercise_assignments do |t|
      t.references :workout, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
