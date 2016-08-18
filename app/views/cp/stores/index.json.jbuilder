json.array!(@cp_stores) do |cp_store|
  json.extract! cp_store, :id, :name
  json.url cp_store_url(cp_store, format: :json)
end
