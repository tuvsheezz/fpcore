json.set! :data do
  json.array! @sales do |sale|
    json.partial! 'sales/sale', sale: sale
    json.url  "
              #{link_to 'Show', sale }
              #{link_to 'Edit', edit_sale_path(sale)}
              #{link_to 'Destroy', sale, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end