json.extract! @task, :id, :name, :role_id, :created_at, :updated_at
json.daily_reviews @task.daily_reviews
