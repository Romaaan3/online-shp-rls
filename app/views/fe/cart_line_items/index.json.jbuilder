json.array!(@fe_cart_line_items) do |fe_cart_line_item|
  json.extract! fe_cart_line_item, :id, :part_id, :cart_id, :q
  json.url fe_cart_line_item_url(fe_cart_line_item, format: :json)
end
