class WorkoutSessionsController < ApplicationController

  def index
    @workout_sessions = WorkoutSession.all
    @workout_sessions = WorkoutSession.order(created_at: :desc)
    @workout_sesssion = WorkoutSession.new
  end

  def new
    @workout_session = WorkoutSession.new
  end

  def show
    @workout_session = WorkoutSession.find(params[:id])
    @exercises = @workout_session.exercises
    # need exercise_sets for the exercise and the workout_session
    @exercise_sets = @exercises
    # create instance(@) for the exercise_sets for the workout_session
  end

  def create
    @workout = Workout.find(params[:workout_id])
    @workout_session = WorkoutSession.new
    @workout_session.user = current_user
    @workout_session.workout = @workout
    @workout_session.start_time = Date.today


    if @workout_session.save
      redirect_to workout_session_path(@workout_session)
    else
      render root_path
    end

  end
end
