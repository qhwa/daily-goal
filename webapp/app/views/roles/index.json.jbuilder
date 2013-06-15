json.array!(@roles) do |role|
  json.extract! role, :name, :relative_to
  json.url role_url(role, format: :json)
end
