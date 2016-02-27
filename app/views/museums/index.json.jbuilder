json.array!(@museums) do |museum|
  json.extract! museum, :id
  json.url museum_url(museum, format: :json)
end
