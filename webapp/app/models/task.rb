class Task < ActiveRecord::Base

  belongs_to  :role
  has_many    :daily_reviews

  validates_presence_of :name
  validates_associated :role

  def need_done_on?( date )
    (date.past? || date.today?) && date >= created_at.to_date
  end

  def daily_review_on( date )
    if need_done_on?( date )
      daily_reviews.where( date: date ).first_or_create!.tap do |review|
        review.need_to_be_done = true
      end
    else
      empty_review( date )
    end
  end

  protected

    def empty_review( date )
      daily_reviews.build( date: date ).tap do |review|
        review.need_to_be_done = false
      end
    end

end
