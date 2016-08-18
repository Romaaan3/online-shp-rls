json.array!(@cp_parts) do |cp_part|
  json.extract! cp_part, :id, :name, :description, :cost_1, :cost_2, :brand_id, :category_id
  json.url cp_part_url(cp_part, format: :json)
end
