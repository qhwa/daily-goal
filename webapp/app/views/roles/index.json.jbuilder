json.array!(@roles) do |role|
  json.extract! role, :name, :id
  json.url role_url(role, format: :json)
end
