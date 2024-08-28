class ExercisesController < ApplicationController


  def index
    if params[:category]
      @exercises = Exercise.where(category: params[:category])
    else
      @exercises = Exercise.all
    end
  end

  def show
    @exercise = Exercise.find(params[:id])
    @workout_session = WorkoutSession.find(params[:workout_session_id])
    @exercises = @workout_session.exercises
    # display progress of current workout_session
    # @exercise_sets = @workout_session.exercise_sets
    # get exercise_set
    # @exercise_set = @exercises.exercise_set
    @exercise_sets = @workout_session.exercise_sets.group_by(&:exercise)

    @exercise_completed = {}
    @workout_session.exercises.each do |exercise|
      @exercise_completed[exercise.name] = false
    end
    @exercise_sets.each do |exercise, exercise_sets|
      @exercise_completed[exercise.name] = exercise_sets.length >= exercise.sets
    end
  end

  def compare
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
      @max_sets = @last_exercise_set.size > @second_last_exercise_set.size ? @last_exercise_set.size : @second_last_exercise_set.size

    @data_hash_sum = Hash.new(0)
    current_user.workout_sessions.each do |workout_session|
      @data_hash_sum[workout_session.start_time] += workout_session.exercise_sets.where(exercise: @exercise).sum { |exercise_set| exercise_set.reps }
    end


    @data_hash_by_year = {}
    @data_hash_sum.each do |date, sum|
      @data_hash_by_year[date.year] = {} if @data_hash_by_year[date.year].nil?
      @data_hash_by_year[date.year][date] = sum
    end

  end

  def new

  end

  def create

  end

  def update

  end

end
