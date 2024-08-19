class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.string :name
      t.integer :upper_reps
      t.integer :lower_reps
      t.integer :reps
      t.integer :hold_time
      t.integer :duration
      t.integer :rest
      t.string :tempo
      t.string :category
      t.string :type
      t.integer :progression_difficulty
      t.string :progression_name

      t.timestamps
    end
  end
end
