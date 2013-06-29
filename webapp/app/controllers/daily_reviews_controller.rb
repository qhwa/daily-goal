class DailyReviewsController < ApplicationController

  before_filter :find_task
  before_filter :find_review, only: [:get_done]

  def index
    @reviews = @task.daily_reviews
  end

  def get_done
    if @review.update_attributes( done: true )
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  protected

    def find_task
      @task = Task.find params[:task_id]
    end

    def find_review
      @review = DailyReview.find( params[:id] )
    end
end
