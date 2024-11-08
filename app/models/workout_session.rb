class WorkoutSession < ApplicationRecord
  belongs_to :user
  belongs_to :workout
  has_many :exercise_sets
  has_many :exercises, through: :exercise_assignments
  has_many :exercise_assignments, through: :workout
  def sets_done(exercise)
    self.exercise_sets.select { |ex| ex.exercise == exercise }
  end
end
