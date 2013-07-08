json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :point
  json.url task_url(task, format: :json)
  json.role task.role
end
