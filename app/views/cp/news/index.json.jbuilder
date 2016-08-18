json.array!(@cp_news) do |cp_news|
  json.extract! cp_news, :id, :name, :anons, :text
  json.url cp_news_url(cp_news, format: :json)
end
