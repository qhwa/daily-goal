json.array!(@roles) do |role|
  json.extract! role, :display_name, :name, :relative_to, :id
  json.url role_url(role, format: :json)
end
