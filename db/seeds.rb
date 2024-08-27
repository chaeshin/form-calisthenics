# require "open-uri"
# require "nokogiri"
#
require 'securerandom'
require "faker"
require "roo"

puts " "
puts "Cleaning the DB..."
ExerciseSet.destroy_all
ExerciseAssignment.destroy_all
User.destroy_all
WorkoutSession.destroy_all
Workout.destroy_all
Exercise.destroy_all


puts " "
puts "Creating users accounts for Chae, Ryo and Nick..."

User.create!(
  email: "nk.matsumoto@gmail.com",
  password: "password",
  username: "nkmatsumoto"
)

User.create!(
  email: "chaewanshin@gmail.com",
  password: "password",
  username: "chaewanshin"
)
User.create!(
  email: "stuntpad@gmail.com",
  password: "password",
  username: "stuntpad"
)

user_count = 10
puts " "
puts "Creating #{user_count} random users..."

user_count.times do
  User.create(
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 8),
    username: Faker::Internet.unique.username
  )
end


puts " "
puts "Creating workouts, exercises and exercise assignments ... "
xlsx = Roo::Excelx.new('./db/data/workout_data.xlsx')

# Reading data from the first sheet
puts " "
puts "Parsing spreadsheet data for workouts and exercises  ... "
xlsx.sheet('Skills Workout').parse do |row|
  next if row[1..6].all?(nil)
  # Access the cell data with row[cell_index]
  p row[0..5] # Example: Print the value of the first cell

  if row[0] == "T"
    workout_name = row[6].gsub(/<\/?[^>]+>/, "")
    workout = Workout.find_by(name: workout_name )
    if workout.nil?
    # create workout
      workout = Workout.new(
        name: workout_name,
        category: row[2],
      )
      workout.save
      puts " "
      puts " ----------------------------------- "
      puts " Created new workout: #{workout.name} "
      puts " ----------------------------------- "
      puts " "
      p workout
    end

    # p workout.errors
  else
    # create exercise
    if row[5].end_with?("s")
      upper_reps = nil
      lower_reps = nil
    else
      reps_array = row[5]&.split('-')
      upper_reps = reps_array.nil? && reps_array.size >= 2 ? nil : reps_array[1].to_i
      lower_reps = reps_array.nil? && reps_array.size >= 2 ? nil : reps_array[0].to_i
    end

    hold_time = row[5].end_with?("s") ? row[4][0..-1].to_i : nil

    exercise_name = row[5]
    exercise = Exercise.find_by(name: exercise_name )
    if exercise.nil?
      exercise = Exercise.new(
      name: row[6],
      upper_reps: upper_reps,
      lower_reps: lower_reps,
      reps: lower_reps,
      sets: row[4],
      hold_time: hold_time,
      duration: nil,
      rest: row[1].to_i,
      tempo: row[0].to_s,
      category: row[2],
      exercise_type: row[3],
      ref_video_link: row[7],
      progression_difficulty: nil,
      progression_name: nil
      )
      exercise.save!
    end

    # create exercise assignment
    p workout
    p exercise
    assignment = ExerciseAssignment.new(
      workout_id: Workout.last.id,
      exercise_id: exercise.id
    )
    assignment.save
    puts "Created #{exercise.name} and added to #{assignment.workout.name}... "
    puts " "
  end


end



# Reading data from the first sheet
puts " "
puts "Parsing spreadsheet data for Workout Sessions  ... "

def create_exercise_set(reps, workout_session, exercise, video_path)
  exercise_set = ExerciseSet.new(
    reps: reps,
    workout_session: workout_session,
    exercise: exercise
  )

  unless video_path.nil?
    file = File.open(File.join(Rails.root, video_path))
    exercise_set.video.attach(io: file, filename: "#{exercise}.mp4", content_type: 'video/mp4')
    p exercise_set.video.key
  end

  exercise_set.save!
  puts "Created #{exercise_set.reps} reps for #{exercise_set.exercise.name} ... "
  puts " "
end

xlsx.sheet('Planche').parse do |row|
  # next if row[1..6].all?(nil)
  # Access the cell data with row[cell_index]
  p row[0..4] # Example: Print the value of the first cell

  if row[0] == "Workout"
    puts "Skipping header row"
  else
    if row[1] == "First Knuckle Push Up"
      workout_session = WorkoutSession.create(
      user: User.first,
      workout: Workout.first,
      bodyweight: 70.0,
      sleep_time: 7 * 60,
      start_time: row[2] + 11.hour,
      end_time: row[2] + 13.hour
      )
      puts "Created #{workout_session.workout.name} ... "
      puts " "

      exercise = Exercise.find_by(name: row[1])
      create_exercise_set(row[3], workout_session, exercise, row[4])

    else
      exercise = Exercise.find_by(name: row[1])
      create_exercise_set(row[3], WorkoutSession.last, exercise, row[4])
    end
  end

end

puts " "
puts "Created: #{User.all.count} users, #{Workout.all.count} workouts, #{Exercise.all.count} exercises and #{ExerciseAssignment.all.count} exercise assignments"


# workout_session = WorkoutSession.create(
#   user: User.first,
#   workout: Workout.first,
#   bodyweight: 70.0,
#   sleep_time: 7 * 60,
# )
# workout_session.exercises.each do |exercise|
#   p exercise.name
#   exercise.sets.times do
#     exercise_set = ExerciseSet.new(
#       reps: exercise.reps,
#       workout_session: workout_session,
#       exercise: exercise
#     )
#     exercise_set.save!
#   end
# end

# exercise_set = ExerciseSet.new(
#   reps: 6,
#   workout_session: workout_session,
#   exercise: workout_session.workout.exercises.first
# )
# file = File.open(File.join(Rails.root, "public/videos/video1.mp4"))
# exercise_set.video.attach(io: file, filename: 'video1.mp4', content_type: 'video/mp4')
# p exercise_set.video.key
# exercise_set.save!

# exercise_set2 = ExerciseSet.new(
#   reps: 6,
#   workout_session: workout_session,
#   exercise: workout_session.workout.exercises.first
#   )

#   file2 = File.open(File.join(Rails.root, "public/videos/video2.mp4"))
#   exercise_set2.video.attach(io: file2, filename: 'video2.mp4', content_type: 'video/mp4')
#   p exercise_set2.video.key
#   exercise_set2.save!
