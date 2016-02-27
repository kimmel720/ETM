json.array!(@floor_plans) do |floor_plan|
  json.extract! floor_plan, :id, :name
  json.url floor_plan_url(floor_plan, format: :json)
end
