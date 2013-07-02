class DailyReview < ActiveRecord::Base

  belongs_to :task

  validates_presence_of :task_id, :date
  validates_uniqueness_of :date, :scope => :task_id
  validate :check_date_after_task_created

  attr_accessor :need_to_be_done

  def need_to_be_done?
    @need_to_be_done
  end

  def to_param
    date.strftime '%Y-%m-%d'
  end

  protected

    # review的时间应该在任务创建之后
    def check_date_after_task_created
      if task.persisted? && date < task.created_at.to_date
        errors.add :date, 'should after task created'
      end
    end

end
