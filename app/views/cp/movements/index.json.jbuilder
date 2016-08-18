json.array!(@cp_movements) do |cp_movement|
  json.extract! cp_movement, :id, :from_store_id, :to_store_id, :description
  json.url cp_movement_url(cp_movement, format: :json)
end
