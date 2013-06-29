class CreateDailyReviews < ActiveRecord::Migration
  def change
    create_table :daily_reviews do |t|
      t.integer :task_id, null: false
      t.date :date,       null: false
      t.boolean :done,    default: false

      t.timestamps
    end
    add_index :daily_reviews, [:task_id, :date]
    add_index :daily_reviews, [:task_id, :done]
    add_index :daily_reviews, [:task_id]
    add_index :daily_reviews, [:done]
  end
end
