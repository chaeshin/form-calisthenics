class WorkoutSession < ApplicationRecord
  belongs_to :user
  belongs_to :workout
  has_many :exercise_sets
end
