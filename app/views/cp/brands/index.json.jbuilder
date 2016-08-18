json.array!(@cp_brands) do |cp_brand|
  json.extract! cp_brand, :id, :name
  json.url cp_brand_url(cp_brand, format: :json)
end
