class WorkoutSession < ApplicationRecord
  belongs_to :user
  belongs_to :workout
  has_many :exercise_sets, dependent: :delete_all
  has_many :exercise_assignments, through: :workout, dependent: :delete_all
  has_many :exercises, through: :exercise_assignments, dependent: :delete_all

  def sets_done(exercise)
    self.exercise_sets.select { |ex| ex.exercise == exercise }
  end
end
