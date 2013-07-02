class AddFieldMsgToDailyReviews < ActiveRecord::Migration
  def change
    add_column :daily_reviews, :msg, :string
  end
end
