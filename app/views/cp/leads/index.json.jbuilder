json.array!(@cp_leads) do |cp_lead|
  json.extract! cp_lead, :id, :name, :tel
  json.url cp_lead_url(cp_lead, format: :json)
end
