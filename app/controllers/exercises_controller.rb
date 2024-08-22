class ExercisesController < ApplicationController

  def show
    @workout_session = WorkoutSession.find(params[:id])
    @exercises = @workout_session.exercises
  end

  def new

  end

  def create

  end

  def update

  end

end
