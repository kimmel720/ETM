json.array!(@exhibitions) do |exhibition|
  json.extract! exhibition, :id
  json.url exhibition_url(exhibition, format: :json)
end
