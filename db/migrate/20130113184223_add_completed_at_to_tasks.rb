class AddCompletedAtToTasks < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.date :completed_at, :default => nil
    end
  end
end
