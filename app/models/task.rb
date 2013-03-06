class Task < ActiveRecord::Base
  belongs_to :user
  # attr_accessible :title, :body
  #
  validates_presence_of :title

  def self.completed
    where('completed_at is not null')
  end

  def self.accepted_params
    {
    "title" => "task title",
    "priority" => "task priority",
    "task_list" => "task priority",
    "completed_at" => "completed_at",
    "updated_at" => "updated_at",
    "created_at" => "created_at",
    "due_date" => "due_date",
    "due_time" => "due time",
    "repeat" => "repeat"
    }
  end

  def self.from_params(params)
    task = Task.new.tap do |t|
      # assign accepted keys to Task instance
      task_params = params['task']
      (task_params.keys & accepted_params.keys).each do |key|
        t.send("#{key}=".to_sym, task_params[key])
      end
    end
  end

end
