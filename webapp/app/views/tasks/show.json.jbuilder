json.extract! @task, :id, :name, :created_at, :updated_at
json.daily_reviews @task.daily_reviews
json.role @task.role
