class ExerciseSet < ApplicationRecord
  belongs_to :workout_session
  belongs_to :exercise
  has_one_attached :video

  validates :reps, numericality: { greater_than_or_equal_to: 0 }
  # validates :set_duration, numericality: { greater_than_or_equal_to: 0 }


  validates :workout_session, presence: true
  validates :exercise, presence: true

  def completed?
    self.reps.class == Integer
  end
end
