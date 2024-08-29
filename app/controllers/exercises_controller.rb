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
      @last_workout_session = @workout_sessions_hash.keys.find { |workout_session| workout_session.id == params[:first_date].to_i}
      @last_exercise_set = @workout_sessions_hash[@last_workout_session] || []

      @second_last_workout_session = @workout_sessions_hash.keys.find { |workout_session| workout_session.id == params[:second_date].to_i }
      @second_last_exercise_set = @workout_sessions_hash[@second_last_workout_session] || []
    else
      @last_two_sessions = @workout_sessions_hash.keys.sort.last(2)
      @last_exercise_set = @workout_sessions_hash[@last_two_sessions.last] || []
      @second_last_exercise_set = @workout_sessions_hash[@last_two_sessions[0]] || []
    end
      @max_sets = @exercise.sets

    @data_hash_sum = Hash.new(0)
    current_user.workout_sessions.each do |workout_session|
      reps = workout_session.exercise_sets.where(exercise: @exercise).sum { |exercise_set| exercise_set.reps }
      @data_hash_sum[workout_session.start_time] += reps if reps.positive?
    end


    @data_hash_by_year = {}
    @data_hash_sum.each do |date, sum|
      @data_hash_by_year[date.year] = {} if @data_hash_by_year[date.year].nil?
      @data_hash_by_year[date.year][date] = sum
    end

    @data_hash_average_per_set = Hash.new(0)
    current_user.workout_sessions.each do |workout_session|
      exercise_sets = workout_session.exercise_sets.where(exercise: @exercise)
      @exercise.sets.times do |set_number|
        @data_hash_average_per_set[set_number + 1] += exercise_sets[set_number].reps unless exercise_sets[set_number].nil?
      end
    end

    @total_workout_sessions_with_exercise = 0
    current_user.workout_sessions.each do |workout_session|
      @total_workout_sessions_with_exercise += workout_session.exercise_sets.where(exercise: @exercise).count
    end

    @total_workout_sessions_with_exercise = @total_workout_sessions_with_exercise / @exercise.sets

    @exercise.sets.times do |set_number|
      @data_hash_average_per_set[set_number + 1] = @data_hash_average_per_set[set_number + 1].fdiv(@total_workout_sessions_with_exercise).round(2)
    end
  end

  def new

  end

  def create

  end

  def update

  end

end
