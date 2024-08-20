class AddSetsToExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :exercises, :sets, :integer, default: 3
  end
end
