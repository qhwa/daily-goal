json.array!(@roles) do |role|
  json.extract! role, :name, :id, :tasks_count
  json.url role_url(role, format: :json)
end
