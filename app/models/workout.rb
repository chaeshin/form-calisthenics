class Workout < ApplicationRecord
  belongs_to :user, optional: true
  has_many :exercise_assignments, dependent: :destroy
  has_many :workout_sessions
  has_many :exercises, through: :exercise_assignments
  has_many :exercise_sets, through: :workout_sessions

  validates :name, presence: true
  validates :category, presence: true

  include PgSearch::Model

  pg_search_scope :search_by,
    against: [:name, :category],
    associated_against: {
      user: [:username]
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

end
