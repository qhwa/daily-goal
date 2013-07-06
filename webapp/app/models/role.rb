class Role < ActiveRecord::Base

  validates_presence_of :name

  has_many :tasks

  def display_name
    name, relative_to = self.name, self.relative_to
    if relative_to.present?
      "#{name} of #{relative_to}"
    else
      name
    end
  end

end
