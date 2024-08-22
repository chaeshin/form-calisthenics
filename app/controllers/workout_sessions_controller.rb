class WorkoutSessionsController < ApplicationController

  def index
    @workout_sessions = WorkoutSession.all
    @workout_sesssion = WorkoutSession.new
  end

  def show
    @workout_session = WorkoutSession.find(params[:id])
    @exercises = @workout_session.exercises
  end

  def create

  end
end
