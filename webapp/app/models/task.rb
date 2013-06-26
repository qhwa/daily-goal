class Task < ActiveRecord::Base

  belongs_to :role

  validates_presence_of :name
  validates_associated :role

end
