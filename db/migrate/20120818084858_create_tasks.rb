class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title, :description
      t.date :due
      t.integer :priority
      t.references :user

      t.timestamps
    end
  end
end
