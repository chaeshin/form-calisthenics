class ExercisesController < ApplicationController

  def index
    @exercises = Exercise.all
  end

  def show
    @exercise = Exercise.find(params[:id])
    @exercises = Exercise.where
    # @workout = Workout.find(params[:id])
    # @workout_sessions = WorkoutSession.where(workout_id: params[:id])
    # @exercises = @workout.exercises
  end

  def new

  end

  def create

  end

  def update

  end

end
