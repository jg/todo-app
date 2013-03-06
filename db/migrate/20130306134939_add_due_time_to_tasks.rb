class AddDueTimeToTasks < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.integer :due_time
    end
  end
end
