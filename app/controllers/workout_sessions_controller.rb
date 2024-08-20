class WorkoutSessionsController < ApplicationController

  def index

  end

  def show
    @workout_session = WorkoutSession.find(params[:id])
    @exercises = @workout_session.exercises
  end

  def create

  end
end
