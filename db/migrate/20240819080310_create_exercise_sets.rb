class CreateExerciseSets < ActiveRecord::Migration[7.1]
  def change
    create_table :exercise_sets do |t|
      t.integer :reps
      t.integer :set_duration
      t.references :workout_session, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
