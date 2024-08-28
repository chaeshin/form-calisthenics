class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def dashboard
    if params[:query].present?
      @workouts = Workout.search_by(params[:query])
    else
      @workouts = Workout.all
    end
    @workout_sess = WorkoutSession.new
  end

  def calendar

  end

  def home

  end
end
