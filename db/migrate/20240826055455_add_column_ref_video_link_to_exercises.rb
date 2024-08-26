class AddColumnRefVideoLinkToExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :exercises, :ref_video_link, :string
  end
end
