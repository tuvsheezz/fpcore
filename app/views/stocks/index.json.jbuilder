json.set! :data do
  json.array! @stocks do |stock|
    json.partial! 'stocks/stock', stock: stock
    json.url  "
              #{link_to 'Show', stock }
              #{link_to 'Edit', edit_stock_path(stock)}
              #{link_to 'Destroy', stock, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end