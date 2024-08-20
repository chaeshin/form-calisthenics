class WorkoutSession < ApplicationRecord
  belongs_to :user
  belongs_to :workout
  has_many :exercise_sets
  has_many :exercise_assignments, through: :workout
  has_many :exercises, through: :exercise_assignments
end
