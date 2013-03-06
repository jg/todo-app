class AddRepeatAndCompletedAtToTasks < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.string "repeat"
    end

    change_column :tasks, :completed_at, :timestamp
  end
end
