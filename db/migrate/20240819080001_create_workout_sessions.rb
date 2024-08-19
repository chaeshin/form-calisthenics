class CreateWorkoutSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :workout_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :workout, null: false, foreign_key: true
      t.datetime :start_time
      t.float :bodyweight
      t.integer :sleep_time

      t.timestamps
    end
  end
end
