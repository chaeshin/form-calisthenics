class ExercisesController < ApplicationController


  def index
    @exercises = Exercise.all
  end

  def show
    @workout_session = WorkoutSession.find(params[:id])
    @exercises = @workout_session.exercises
  end

  def view
    @exercise = Exercise.find(params[:id])
    # @exercise_set = ExerciseSet.where(exercise: @exercise)
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
