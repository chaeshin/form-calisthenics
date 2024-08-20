class Workout < ApplicationRecord
  belongs_to :user, optional: true
  has_many :exercise_assignments, dependent: :destroy
  has_many :exercises, through: :exercise_assignments
  has_many :exercise_sets, through: :workout_sessions

  validates :name, presence: true
  validates :category, presence: true
end
