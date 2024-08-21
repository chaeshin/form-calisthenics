class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if params[:query].present?
      @workouts = Workout.search_by(params[:query])
    else
      @workouts = Workout.all
    end
  end

  def dashboard

  end

end
