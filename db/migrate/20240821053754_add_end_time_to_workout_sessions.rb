class AddEndTimeToWorkoutSessions < ActiveRecord::Migration[7.1]
  def change
    add_column :workout_sessions, :end_time, :datetime
  end
end
