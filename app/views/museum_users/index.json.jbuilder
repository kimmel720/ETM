json.array!(@museum_users) do |museum_user|
  json.extract! museum_user, :id
  json.url museum_user_url(museum_user, format: :json)
end
