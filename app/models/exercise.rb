class Exercise < ApplicationRecord

    # Associations
    has_many :exercise_assignments, dependent: :destroy
    has_many :workouts, through: :exercise_assignments
    has_many :exercise_sets

    # Validations
    validates :name, presence: true
    validates :upper_reps, :lower_reps, :rest, :reps, :hold_time, :duration, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validates :progression_difficulty, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
end
