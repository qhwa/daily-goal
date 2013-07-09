class Role < ActiveRecord::Base

  validates_presence_of :name

  has_many :tasks

  # TODO: use cache
  def tasks_count
    tasks.count
  end

end
