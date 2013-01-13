class Task < ActiveRecord::Base
  belongs_to :user
  # attr_accessible :title, :body
  #
  def self.completed
    where('completed_at is not null')
  end
end
