class WorkoutsController < ApplicationController

  def index
    @workouts = Workout.all
    @workout = Workout.new
  end

  def show
    @workout = Workout.find(params[:id])
    @exercises = @workout.exercises
  end

  def new
    @workout = Workout.new
  end

  def update

  end

  def create
    @workout = Workout.new(workout_params)
    @workout.user = current_user
    if @workout.save
      redirect_to workouts_path, notice: "Workout was successfully created"
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def workout_params
    params.required(:workout).permit(:name, :category)
  end
end
