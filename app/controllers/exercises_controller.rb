class ExercisesController < ApplicationController


  def index
    @exercises = Exercise.all
  end

  def show
    @exercise = Exercise.find(params[:id])
    @workout_session = WorkoutSession.find(params[:workout_session_id])
    @exercises = @workout_session.exercises

    # display progress of current workout_session
    # @exercise_sets = @workout_session.exercise_sets

  end

  def view
    @exercise = Exercise.find(params[:id])
    @workout_sessions = WorkoutSession.where(exercise: @exercise)
    @exercises = @workout_sessions.each do |workout_session|
      workout_session.exercise.find(@exercise)
    end

    @exercise_set = ExerciseSet.where(exercise: @exercise)
    @workout_sessions = WorkoutSession.where(workout_id: params[:id])
    # @workout = Workout.find(params[:id])
    # @exercises = @workout.exercises
  end

  def new

  end

  def create

  end

  def update

  end

end
