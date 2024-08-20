class ExerciseAssignment < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise

  validates :workout, presence: true
  validates :exercise, presence: true
end
