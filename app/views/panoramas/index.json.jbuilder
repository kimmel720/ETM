json.array!(@panoramas) do |panorama|
  json.extract! panorama, :id, :name
  json.url panorama_url(panorama, format: :json)
end
