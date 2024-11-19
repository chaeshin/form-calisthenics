class WorkoutSession < ApplicationRecord
  belongs_to :user
  belongs_to :workout
  has_many :exercise_sets
  has_many :exercise_assignments, through: :workout
  has_many :exercises, through: :exercise_assignments
  def sets_done(exercise)
    self.exercise_sets.select { |ex| ex.exercise == exercise }
  end
end
