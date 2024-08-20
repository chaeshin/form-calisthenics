class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :workouts, dependent: :destroy
  has_many :workout_sessions, dependent: :destroy
  validates :username, presence: true, uniqueness: true
  validates :birthday, presence: true
  validates :height, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
