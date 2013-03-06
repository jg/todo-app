class RenameDueTasksAttribute < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.rename :due, :due_date
    end
  end
end
