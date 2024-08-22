class ExercisesController < ApplicationController

  def show
    @exercise = Exercise.find(params[:id])
    @workout_session = WorkoutSession.find(params[:workout_session_id])
    @exercises = @workout_session.exercises
  end

  def new

  end

  def create

  end

  def update

  end

end
