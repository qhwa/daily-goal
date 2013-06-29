class DailyReview < ActiveRecord::Base

  belongs_to :task

  validates_presence_of :task_id, :date

  attr_accessor :need_to_be_done

  def need_to_be_done?
    @need_to_be_done
  end

end
