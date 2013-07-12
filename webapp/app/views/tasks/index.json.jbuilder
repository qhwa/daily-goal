json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :point
  json.url task_url(task, format: :json)
  json.role task.role
  json.review task.daily_review_on( @date ) if @date
end
