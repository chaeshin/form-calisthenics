class Videos::ExercisesController < ApplicationController
  def show
    @exercise = Exercise.find(params[:id])
    @workout_sessions_hash = @exercise.exercise_sets.group_by(&:workout_session)
    if params[:first_date] && params[:second_date]
      @last_workout_session = @workout_sessions_hash.keys.find { |workout_session| workout_session.start_time == params[:first_date] }
      @last_exercise_set = @workout_sessions_hash[@last_workout_session]

      @second_last_workout_session = @workout_sessions_hash.keys.find { |workout_session| workout_session.start_time == params[:second_date] }
      @second_last_exercise_set = @workout_sessions_hash[@second_last_workout_session]
    else
      @last_two_sessions = @workout_sessions_hash.keys.sort.last(2)
      @last_exercise_set = @workout_sessions_hash[@last_two_sessions.last]
      @second_last_exercise_set = @workout_sessions_hash[@last_two_sessions[0]]
    end
  end
end
