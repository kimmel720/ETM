json.array!(@artworks) do |artwork|
  json.extract! artwork, :id, :img_path, :description, :date_created
  json.url artwork_url(artwork, format: :json)
end
