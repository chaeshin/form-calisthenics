# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_19_080310) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercise_assignments", force: :cascade do |t|
    t.bigint "workout_id", null: false
    t.bigint "exercise_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_exercise_assignments_on_exercise_id"
    t.index ["workout_id"], name: "index_exercise_assignments_on_workout_id"
  end

  create_table "exercise_sets", force: :cascade do |t|
    t.integer "reps"
    t.integer "set_duration"
    t.bigint "workout_session_id", null: false
    t.bigint "exercise_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_exercise_sets_on_exercise_id"
    t.index ["workout_session_id"], name: "index_exercise_sets_on_workout_session_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.integer "upper_reps"
    t.integer "lower_reps"
    t.integer "reps"
    t.integer "hold_time"
    t.integer "duration"
    t.integer "rest"
    t.string "tempo"
    t.string "category"
    t.string "type"
    t.integer "progression_difficulty"
    t.string "progression_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workout_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "workout_id", null: false
    t.datetime "start_time"
    t.float "bodyweight"
    t.integer "sleep_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workout_sessions_on_user_id"
    t.index ["workout_id"], name: "index_workout_sessions_on_workout_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "exercise_assignments", "exercises"
  add_foreign_key "exercise_assignments", "workouts"
  add_foreign_key "exercise_sets", "exercises"
  add_foreign_key "exercise_sets", "workout_sessions"
  add_foreign_key "workout_sessions", "users"
  add_foreign_key "workout_sessions", "workouts"
  add_foreign_key "workouts", "users"
end
