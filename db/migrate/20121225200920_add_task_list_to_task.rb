class AddTaskListToTask < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.string :task_list
    end
  end
end
