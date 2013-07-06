class DailyReviewsController < ApplicationController

  respond_to :json

  before_filter :find_task
  before_filter :find_review, only: [:get_done, :show, :update]

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

  def show
  end

  def update
    @review.update app_params
    respond_with @review
  end

  protected

    def find_task
      @task = Task.find params[:task_id]
    end

    def find_review
      date = Date.parse(params[:id])
      if @task.need_done_on?(date)
        @review = @task.daily_reviews.where( date: date ).first_or_initialize
      end
    end

  private

    def app_params
      params.require(:daily_review).permit(:done, :msg)
    end
end
