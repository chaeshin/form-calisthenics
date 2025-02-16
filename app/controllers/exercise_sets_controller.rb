class ExerciseSetsController < ApplicationController

  def create
    @exercise_set = ExerciseSet.new(exercise_set_params)
    @exercise_set.exercise = Exercise.find(params[:exercise_id])
    @exercise_set.set_duration = 10
    if @exercise_set.save
      respond_to do |format|
        format.html # Follow regular flow of Rails
        format.text { render partial: 'shared/cl_video_tag', locals: { exercise_set: @exercise_set }, formats: [:html] }
      end
    else
      render 'workout_session', status: :unprocessable_entity
    end
  end

  def exercise_set_params
    params.require(:exercise_set).permit(:video, :reps, :workout_session_id)
  end
end
